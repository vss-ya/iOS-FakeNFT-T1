//
//  StatisticsWebViewViewController.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 18.06.2024.
//

import UIKit
import WebKit

final class StatisticsWebViewViewController: UIViewController {
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    private var viewModel: StatisticsWebViewViewModelProtocol?
    
    // MARK: - Lifecycle
    
    func applyViewModel(_ newViewModel: StatisticsWebViewViewModelProtocol) {
        viewModel = newViewModel
        bind()
        viewModel?.initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    func load(request: URLRequest) {
        webView.load(request)
    }
    
    private func setupViewController() {
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func bind() {
        viewModel?.updateData = { [weak self] request in
            guard let self else { return }
            self.webView.load(request)
        }
        
        viewModel?.updateProgressValue = { [weak self] progress in
            guard let self else { return }
           
        }
    }
}

