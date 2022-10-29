//
//  WebViewAction.swift
//  
//
//  Created by Dionne Lie-Sam-Foek on 09/10/2022.
//

import SwiftUI
import WebKit

/// Describes all the actions the web view can take.
public enum WebViewAction: Equatable {
    /// The web view will not take any action and remains idle.
    case idle
    /// The web view will load the given URL request and navigate to its content.
    /// - Parameter urlRequest: The URL request to load and navigate to.
    case load(URLRequest)
    /// The web view will load the given HTML string as its content.
    /// - Parameter htmlString: A string containing the HTML content.
    case loadHTML(String)
    /// The web view will reload its current webpage.
    case reload
    /// The web view will navigate to the back item in the back-forward list.
    case goBack
    /// The web view will navigate to the forward item in the back-forward list.
    case goForward
    /// The web view will navigate to an item from the back-forward list and sets it as the current item.
    /// - Parameter item: The item in the back-forward list to navigate to.
    case goToItem(WKBackForwardListItem)
    /// Evaluates the specified JavaScript string.
    /// - Parameter javaScriptString: The JavaScript string to evaluate.
    /// - Parameter completionHandler: A handler block to process the result after script evaluation finishes.
    case evaluateJS(String, (Any?) -> Void)
    /// Gets the HTML source of the current webpage.
    /// - Parameter completionHandler: A handler block to process the HTML source string after getting it.
    case getHTML((String?) -> Void)
    
    /// Returns a Boolean value indicating whether two actions are equal.
    /// - Parameters:
    ///   - lhs: The left hand side action.
    ///   - rhs: The right hand side action.
    public static func == (lhs: WebViewAction, rhs: WebViewAction) -> Bool {
        switch (lhs, rhs) {
            case (.idle, .idle)                                                 : return true
            case (.load(let lhsRequest), .load(let rhsRequest))                 : return lhsRequest == rhsRequest
            case (.loadHTML(let lhsString), .loadHTML(let rhsString))           : return lhsString == rhsString
            case (.reload, .reload)                                             : return true
            case (.goBack, .goBack)                                             : return true
            case (.goForward, .goForward)                                       : return true
            case (.goToItem(let lhsItem), .goToItem(let rhsItem))               : return lhsItem == rhsItem
            case (.evaluateJS(let lhsScript, _), .evaluateJS(let rhsScript, _)) : return lhsScript == rhsScript
            case (.getHTML(_), .getHTML(_))                                     : return true
            case _                                                              : return false
        }
    }
}

extension WKWebView {
    func performAction(_ action: WebViewAction) {
        switch action {
            case .idle                                 : break
            case .load(let request)                    : load(request)
            case .loadHTML(let html)                   : loadHTMLString(html, baseURL: nil)
            case .reload                               : reload()
            case .goBack                               : goBack()
            case .goForward                            : goForward()
            case .goToItem(let item)                   : go(to: item)
            case .evaluateJS(let script, let callback) : evaluateJavaScript(script) { response, _ in callback(response) }
            case .getHTML(let callback)                : getHTML(callback)
        }
    }
    
    func getHTML(_ completionHandler: @escaping (String?) -> Void) {
        let script = "document.documentElement.outerHTML.toString()"
        
        evaluateJavaScript(script) { response, _ in
            completionHandler(response as? String)
        }
    }
}
