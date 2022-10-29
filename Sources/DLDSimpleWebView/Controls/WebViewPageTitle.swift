//
//  WebViewPageTitle.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI

/// Displays a title for the web view if there is one, otherwise will display the alternate title given.
public struct WebViewPageTitle: View {
    /// The possible title of the current webpage in the web view.
    public let pageTitle: String?
    /// The alternate title to display if there is no page title.
    public let alternateTitle: String
    
    /// Creates the view displaying a title for the web view if there is one, otherwise will display the alternate title given.
    /// - Parameters:
    ///   - pageTitle: The possible title of the current webpage in the web view.
    ///   - alternateTitle: The alternate title to display if there is no page title.
    public init(pageTitle: String?, alternateTitle: String) {
        self.pageTitle = pageTitle
        self.alternateTitle = alternateTitle
    }
    
    public var body: some View {
        Group {
            if let pageTitle {
                Text(pageTitle)
            } else {
                Text(alternateTitle)
            }
        }
    }
}

private extension WebViewPageTitle {
    
}

struct WebViewPageTitle_Previews: PreviewProvider {
    static var previews: some View {
        WebViewPageTitle(pageTitle: nil, alternateTitle: "N/A")
    }
}
