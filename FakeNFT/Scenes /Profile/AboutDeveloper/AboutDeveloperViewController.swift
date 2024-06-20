//
//  AboutDeveloperViewController.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit
import WebKit

final class AboutDeveloperViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {

    private let webView: WKWebView = WKWebView()
    private let progressView: UIProgressView = UIProgressView()
    
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        openUrl()
    }
    
    func setupViews() {
        view.addSubview(webView)
        webView.frame = self.view.bounds
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    func openUrl() {
        guard let url = URL(string: "https://www.apple.com") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}

