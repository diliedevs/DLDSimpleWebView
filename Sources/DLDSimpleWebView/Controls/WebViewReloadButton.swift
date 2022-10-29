//
//  WebViewReloadButton.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI

/// Displays a button to reload the current webpage in the web view.
public struct WebViewReloadButton: View {
    /// A binding to the action for the web view to take.
    @Binding public var action: WebViewAction
    /// A Boolean value that indicates whether the web view can be reloaded.
    public let canReload: Bool
    
    /// Creates the view displaying a button to reload the current webpage in the web view.
    /// - Parameters:
    ///   - action: A binding to the action for the web view to take.
    ///   - canReload: A Boolean value that indicates whether the web view can be reloaded.
    public init(action: Binding<WebViewAction>, canReload: Bool) {
        _action = action
        self.canReload = canReload
    }
    
    public var body: some View {
        Button {
            action = .reload
        } label: {
            Label("Reload", systemImage: "arrow.clockwise")
        }
        .disabled(canReload == false)
        .opacity(canReload ? 1 : 0)
        .labelStyle(.iconOnly)
        .padding(.horizontal, 4)
    }
}

private extension WebViewReloadButton {
    
}

struct WebViewReloadButton_Previews: PreviewProvider {
    static var previews: some View {
        WebViewReloadButton(action: .constant(.idle), canReload: true)
    }
}
