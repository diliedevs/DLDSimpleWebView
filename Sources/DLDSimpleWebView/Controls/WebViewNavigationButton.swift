//
//  WebViewNavigationButton.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI
import WebKit

struct WebViewNavigationButton: View {
    @Binding var action: WebViewAction
    let direction: Direction
    let list: [WKBackForwardListItem]
    let disabled: Bool
    
    init(action: Binding<WebViewAction>, direction: WebViewNavigationButton.Direction, list: [WKBackForwardListItem], disabled: Bool) {
        _action        = action
        self.direction = direction
        self.list      = list
        self.disabled  = disabled
    }
    
    var body: some View {
        Menu {
            ForEach(list, id: \.self) { item in
                Button(item.title ?? item.url.absoluteString) {
                    action = .goToItem(item)
                }
            }
        } label: {
            Label(direction.title, systemImage: direction.symbol)
        } primaryAction: {
            switch direction {
                case .back    : action = .goBack
                case .forward : action = .goForward
            }
        }
        .labelStyle(.iconOnly)
        .disabled(disabled)
    }
}

extension WebViewNavigationButton {
    enum Direction: String, Identifiable {
        case back, forward
        
        public var id    : String { rawValue }
        public var title : String { rawValue.capitalized }
        
        public var symbol: String {
            switch self {
                case .back    : return "chevron.backward"
                case .forward : return "chevron.forward"
            }
        }
    }
}

private extension WebViewNavigationButton {
    
}

struct BackForwardButton_Previews: PreviewProvider {
    static var previews: some View {
        ControlGroup {
            WebViewNavigationButton(action: .constant(.idle), direction: .back, list: [], disabled: false)
            WebViewNavigationButton(action: .constant(.idle), direction: .forward, list: [], disabled: false)
        }
        .controlGroupStyle(.navigation)
        .previewLayout(.sizeThatFits)
    }
}
