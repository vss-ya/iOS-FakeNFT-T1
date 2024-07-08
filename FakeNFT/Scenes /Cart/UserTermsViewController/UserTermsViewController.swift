import Foundation
import WebKit

final class UserTermsViewController: UIViewController {
    private let webView: WKWebView = WKWebView()
    private let progressView: UIProgressView = UIProgressView()
    
    private var estimatedProgressObservation: NSKeyValueObservation?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        let backButtonImage = UIImage(systemName: "chevron.left")
        button.setImage(backButtonImage, for: .normal)
        button.tintColor = .yaBlackUniversal
        button.sizeToFit()
        button.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupProgressObservation()
        setConstraints()
        loadWebView()
    }
    
    private func setupViews() {
        progressView.tintColor = .yaBlackUniversal
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        [webView, progressView, backButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupProgressObservation() {
        estimatedProgressObservation = webView.observe(
            \.estimatedProgress,
             options: []
        ) { [weak self] (_, _) in
            guard let self = self else { return }
            self.updateProgress()
        }
    }
    
    private func setConstraints() {
        webView.constraintEdges(to: view)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    private func loadWebView() {
        if let url = URL(string: RequestConstants.userTermsURL) {
            webView.load(URLRequest(url: url))
        }
    }
    
    private func updateProgress() {
        let progress = Float(webView.estimatedProgress)
        progressView.progress = progress
        progressView.isHidden = abs(progress - 1.0) <= 0.0001
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
}
