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
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.tintColor = .ypGreenUniversal
        progressView.progressTintColor = .ypGreenUniversal
        progressView.backgroundColor = .none
        return progressView
    }()
    
    private var viewModel: StatisticsWebViewViewModelProtocol?
    
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    // MARK: - Lifecycle
    
    func applyViewModel(_ newViewModel: StatisticsWebViewViewModelProtocol) {
        viewModel = newViewModel
        bind()
        viewModel?.initialize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
            options: [],
            changeHandler: { [weak self] _, _ in
                guard let self else { return }
                self.viewModel?.didUpdateProgressValue(self.webView.estimatedProgress)
            }
        )
    }
    
    func load(request: URLRequest) {
        webView.load(request)
    }
    
    private func setupViewController() {
        addSubViews()
        applyConstraints()
    }
    
    private func addSubViews() {
        [webView, progressView].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subview)
        }
    }

    private func applyConstraints() {
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
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
            self.progressView.setProgress(progress, animated: true)
        }
        
        viewModel?.hideProgress = { [weak self] hiden in
            guard let self else { return }
            self.progressView.isHidden = hiden
        }
    }
}

