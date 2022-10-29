//
//  WebViewState.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI
import WebKit

/// A structure containing information about the web view.
public struct WebViewState {
    /// A Boolean value that indicates whether the web view is currently loading content.
    public internal(set) var isLoading : Bool
    /// The URL for the current webpage.
    public internal(set) var pageURL : URL?
    /// The page title for the current webpage.
    public internal(set) var pageTitle : String?
    /// An error describing why the web view failed to load.
    public internal(set) var error : Error?
    /// A Boolean value that indicates whether there is a valid back item in the back-forward list.
    public internal(set) var canGoBack : Bool
    /// A Boolean value that indicates whether there is a valid forward item in the back-forward list.
    public internal(set) var canGoForward : Bool
    /// The web view's back-forward list.
    public internal(set) var backForwardList : WKBackForwardList
    
    /// A Boolean value that indicates whether the web view can be reloaded.
    public var canReload: Bool { pageURL != nil }
    
    internal init(isLoading: Bool, pageURL: URL? = nil, pageTitle: String? = nil, error: Error? = nil, canGoBack: Bool, canGoForward: Bool, backForwardList: WKBackForwardList = WKBackForwardList()) {
        self.isLoading       = isLoading
        self.pageURL         = pageURL
        self.pageTitle       = pageTitle
        self.error           = error
        self.canGoBack       = canGoBack
        self.canGoForward    = canGoForward
        self.backForwardList = backForwardList
    }
    
    internal init(webView: WKWebView, error: Error? = nil) {
        self.init(isLoading: webView.isLoading,
                  pageURL: webView.url,
                  pageTitle: webView.title,
                  error: error,
                  canGoBack: webView.canGoBack,
                  canGoForward: webView.canGoForward,
                  backForwardList: webView.backForwardList)
    }
    
    /// Returns an empty web view state with no information.
    public static let empty = WebViewState(isLoading: false, canGoBack: false, canGoForward: false)
}
