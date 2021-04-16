//
//  WebView.swift
//  MyTest
//
//  Created by 杨宇铎 on 3/4/21.
//

import SwiftUI
import WebKit

struct SwiftUIWebView:UIViewRepresentable {
    
    let url:URL?
    
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        return WKWebView(
            frame: .zero,
            configuration: config
        )
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myUrl = url else {
            return
        }
        let request = URLRequest(url: myUrl)
        uiView.load(request)
    }
}

