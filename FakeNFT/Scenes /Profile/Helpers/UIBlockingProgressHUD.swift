//
//  UIBlockingProgressHUD.swift
//  FakeNFT
//
//  Created by vs on 01.07.2024.
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
        ProgressHUD.show()
    }
    
    static func showError(_ error: Error) {
        assert(Thread.isMainThread)
        ProgressHUD.showError("\(error.localizedDescription)")
    }
    
    static func dismiss() {
        assert(Thread.isMainThread)
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
    
}
