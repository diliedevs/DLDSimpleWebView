//
//  WebViewCoordinator.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI
import WebKit

/// A custom instance to communicate changes from the web view to other parts of a SwiftUI interface.
public class WebViewCoordinator: NSObject {
    private let webView: WebView
    var actionInProgress = false
    
    init(webView: WebView) {
        self.webView = webView
    }
    
    func updateState(using webView: WKWebView, error: Error? = nil) {
        self.webView.state = WebViewState(webView: webView, error: error)
        self.webView.action = .idle
        self.actionInProgress = false
    }
}

extension WebViewCoordinator: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateState(using: webView)
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        updateState(using: webView)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        updateState(using: webView, error: error)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        updateState(using: webView)
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        updateState(using: webView)
    }
}

extension WebViewCoordinator: WKUIDelegate {
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
}

extension WKWebView {
    convenience init(coordinator: WebViewCoordinator) {
        self.init(frame: .zero, configuration: WKWebViewConfiguration())
        self.navigationDelegate = coordinator
        self.uiDelegate = coordinator
    }
    
    func updateWithAction(_ action: WebViewAction, coordinator: WebViewCoordinator) {
        if action == .idle || coordinator.actionInProgress { return }
        
        coordinator.actionInProgress = true
        self.performAction(action)
    }
}
