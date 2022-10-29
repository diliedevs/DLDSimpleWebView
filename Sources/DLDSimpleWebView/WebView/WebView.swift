//
//  WebView.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI
import WebKit

#if os(iOS)
/// Creates the SwiftUI compatible view to display interactive web content, such as for an in-app browser.
public struct WebView: UIViewRepresentable {
    @Binding var state : WebViewState
    @Binding var action: WebViewAction
    
    /// Creates a web view by passing `WebViewState` and `WebViewAction` bindings to interact with it.
    /// - Parameters:
    ///   - state: A binding to the state with current information of the web view.
    ///   - action: A binding to the action the web view should take.
    public init(state: Binding<WebViewState>, action: Binding<WebViewAction>) {
        _state = state
        _action = action
    }
    
    /// Creates the web view object and configures its initial state.
    /// - Parameter context: A context structure containing information about the current state of the system.
    public func makeUIView(context: Context) -> WKWebView {
        WKWebView(coordinator: context.coordinator)
    }
    
    /// Updates the state of the web view with new information from SwiftUI.
    /// - Parameters:
    ///   - uiView: The underlying `WKWebView` object.
    ///   - context: A context structure containing information about the current state of the system.
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.updateWithAction(action, coordinator: context.coordinator)
    }
    
    /// Creates the custom instance used to communicate changes from your view to other parts of the SwiftUI interface.
    public func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(webView: self)
    }
}
#endif

#if os(macOS)
/// Creates the SwiftUI compatible view to display interactive web content, such as for an in-app browser.
public struct WebView: NSViewRepresentable {
    @Binding var state : WebViewState
    @Binding var action: WebViewAction
    
    /// Creates a web view by passing `WebViewState` and `WebViewAction` bindings to interact with it.
    /// - Parameters:
    ///   - state: A binding to the state with current information of the web view.
    ///   - action: A binding to the action the web view should take.
    public init(state: Binding<WebViewState>, action: Binding<WebViewAction>) {
        _state = state
        _action = action
    }
    
    /// Creates the web view object and configures its initial state.
    /// - Parameter context: A context structure containing information about the current state of the system.
    public func makeNSView(context: Context) -> WKWebView {
        WKWebView(coordinator: context.coordinator)
    }
    
    /// Updates the state of the web view with new information from SwiftUI.
    /// - Parameters:
    ///   - uiView: The underlying `WKWebView` object.
    ///   - context: A context structure containing information about the current state of the system.
    public func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.updateWithAction(action, coordinator: context.coordinator)
    }
    
    /// Creates the custom instance used to communicate changes from your view to other parts of the SwiftUI interface.
    public func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(webView: self)
    }
}
#endif
