//
//  WebViewURLField.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI

/// Creates a text field with a binding to the URL address and a binding to the action of the web view to load the webpage at that url address.
public struct WebViewURLField: View {
    /// A binding to the string representing the URL address of the webpage to load in the web view.
    @Binding public var urlAddress: String
    /// A binding to the action for the web view to take.
    @Binding public var action: WebViewAction
    
    public var body: some View {
        TextField("URL", text: $urlAddress, prompt: Text("https://"))
            .textFieldStyle(.roundedBorder)
            .labelsHidden()
            .onSubmit {
                if let url = URL(string: urlAddress) {
                    action = .load(URLRequest(url: url))
                }
            }
    }
}

private extension WebViewURLField {
    
}

struct WebViewURLField_Previews: PreviewProvider {
    static var previews: some View {
        WebViewURLField(urlAddress: .constant("https://www.apple.com"), action: .constant(.idle))
    }
}
