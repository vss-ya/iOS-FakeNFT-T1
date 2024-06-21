//
//  AboutDeveloperViewController.swift
//  FakeNFT
//
//  Created by vs on 20.06.2024.
//

import UIKit
import WebKit

final class AboutDeveloperViewController: UIViewController {

    private let webView: WKWebView = WKWebView()
    private let progressView: UIProgressView = UIProgressView()
    
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        openUrl()
    }
    
    private func setup() {
        setupViews()
        
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: []
        ) { [weak self] (_, _) in
            guard let self else { return }
            updateProgress()
        }
    }
    
    private func setupViews() {
        [webView, progressView].forEach {
            $0.frame = view.bounds
            view.addSubview($0)
        }
    }
    
    private func openUrl() {
        guard let url = URL(string: "https://practicum.yandex.ru/") else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func updateProgress() {
        let progress = Float(webView.estimatedProgress)
        progressView.progress = progress
        progressView.isHidden = abs(progress - 1.0) <= 0.0001
    }
    
}
