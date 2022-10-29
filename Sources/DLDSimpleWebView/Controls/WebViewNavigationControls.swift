//
//  WebViewNavigationControls.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI
import WebKit

/// Creates a control group containing a back and forward navigation button to control the navigation of the web view.
///
/// These buttons will also show multiple items from the back-forward list when pressed for a longer time.
public struct WebViewNavigationControls: View {
    /// A binding to the action that the web view should take.
    @Binding public var action: WebViewAction
    /// The state of the webview.
    public let state: WebViewState
    
    /// Creates a control group containing a back and forward navigation button to control the navigation of the web view.
    /// - Parameters:
    ///   - action: A binding to the action that the web view should take.
    ///   - state: The state of the webview.
    public init(action: Binding<WebViewAction>, state: WebViewState) {
        _action    = action
        self.state = state
    }
    
    public var body: some View {
        ControlGroup {
            WebViewNavigationButton(action: $action, direction: .back, list: backList, disabled: state.canGoBack == false)
                .padding(.horizontal, 4)
            WebViewNavigationButton(action: $action, direction: .forward, list: forwardList, disabled: state.canGoForward == false)
                .padding(.horizontal, 4)
        }
        .controlGroupStyle(.navigation)
    }
}

private extension WebViewNavigationControls {
    var backList: [WKBackForwardListItem] { state.backForwardList.backList }
    var forwardList: [WKBackForwardListItem] { state.backForwardList.forwardList }
}

struct WebViewNavigationControls_Previews: PreviewProvider {
    static var previews: some View {
        WebViewNavigationControls(action: .constant(.idle), state: .empty)
    }
}
