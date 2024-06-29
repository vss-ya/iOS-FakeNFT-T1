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
    static func animate() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.colorAnimation = .ypBlack
        ProgressHUD.colorBackground = .clear
        ProgressHUD.animationType = .systemActivityIndicator
        ProgressHUD.show()
    }
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
}
