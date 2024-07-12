//
//  UIBlockingProgressHUD.swift
//  FakeNFT
//
//  Created by Владимир Горбачев on 26.06.2024.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {

    private static var window: UIWindow? {
        return UIApplication.shared.windows.first
    }

    static func show() {
        assert(Thread.isMainThread)
        window?.isUserInteractionEnabled = false
        ProgressHUD.colorAnimation = .ypBlack
        ProgressHUD.colorBackground = .clear
        ProgressHUD.animationType = .activityIndicator
        ProgressHUD.show()
    }

    static func showError(_ error: Error) {
        dismiss()
        ProgressHUD.showError("\(error.localizedDescription)")
    }

    static func dismiss() {
        assert(Thread.isMainThread)
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }

}
