// swiftlint:disable file_length
import Foundation
#if canImport(AppKit)
import AppKit
#endif
#if canImport(UIKit)
import UIKit
#endif
#if canImport(SwiftUI)
import SwiftUI
#endif
#if canImport(DeveloperToolsSupport)
import DeveloperToolsSupport
#endif

#if SWIFT_PACKAGE
private let resourceBundle = Foundation.Bundle.module
#else
private class ResourceBundleClass {}
private let resourceBundle = Foundation.Bundle(for: ResourceBundleClass.self)
#endif

// MARK: - Color Symbols -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
extension ColorResource {

    /// The "YP Background Universal" asset catalog color resource.
    static let ypBackgroundUniversal = ColorResource(name: "YP Background Universal", bundle: resourceBundle)

    /// The "YP Black" asset catalog color resource.
    static let ypBlack = ColorResource(name: "YP Black", bundle: resourceBundle)

    /// The "YP Black Universal" asset catalog color resource.
    static let ypBlackUniversal = ColorResource(name: "YP Black Universal", bundle: resourceBundle)

    /// The "YP Blue Universal" asset catalog color resource.
    static let ypBlueUniversal = ColorResource(name: "YP Blue Universal", bundle: resourceBundle)

    /// The "YP Gray Universal" asset catalog color resource.
    static let ypGrayUniversal = ColorResource(name: "YP Gray Universal", bundle: resourceBundle)

    /// The "YP Green Universal" asset catalog color resource.
    static let ypGreenUniversal = ColorResource(name: "YP Green Universal", bundle: resourceBundle)

    /// The "YP Light Grey" asset catalog color resource.
    static let ypLightGrey = ColorResource(name: "YP Light Grey", bundle: resourceBundle)

    /// The "YP Red Universal" asset catalog color resource.
    static let ypRedUniversal = ColorResource(name: "YP Red Universal", bundle: resourceBundle)

    /// The "YP White" asset catalog color resource.
    static let ypWhite = ColorResource(name: "YP White", bundle: resourceBundle)

    /// The "YP White Universal" asset catalog color resource.
    static let ypWhiteUniversal = ColorResource(name: "YP White Universal", bundle: resourceBundle)

    /// The "YP Yellow Universal" asset catalog color resource.
    static let ypYellowUniversal = ColorResource(name: "YP Yellow Universal", bundle: resourceBundle)

}

// MARK: - Image Symbols -

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
extension ImageResource {

    /// The "LaunchScreen" asset catalog image resource.
    static let launchScreen = ImageResource(name: "LaunchScreen", bundle: resourceBundle)

    /// The "cart_add" asset catalog image resource.
    static let cartAdd = ImageResource(name: "cart_add", bundle: resourceBundle)

    /// The "cart_delete" asset catalog image resource.
    static let cartDelete = ImageResource(name: "cart_delete", bundle: resourceBundle)

    /// The "cart_fill" asset catalog image resource.
    static let cartFill = ImageResource(name: "cart_fill", bundle: resourceBundle)

    /// The "close" asset catalog image resource.
    static let close = ImageResource(name: "close", bundle: resourceBundle)

    /// The "favourites_default" asset catalog image resource.
    static let favouritesDefault = ImageResource(name: "favourites_default", bundle: resourceBundle)

    /// The "favourites_pressed" asset catalog image resource.
    static let favouritesPressed = ImageResource(name: "favourites_pressed", bundle: resourceBundle)

    /// The "profile_avatar_mock" asset catalog image resource.
    static let profileAvatarMock = ImageResource(name: "profile_avatar_mock", bundle: resourceBundle)

    /// The "profile_back" asset catalog image resource.
    static let profileBack = ImageResource(name: "profile_back", bundle: resourceBundle)

    /// The "profile_chevron_forward" asset catalog image resource.
    static let profileChevronForward = ImageResource(name: "profile_chevron_forward", bundle: resourceBundle)

    /// The "profile_clear" asset catalog image resource.
    static let profileClear = ImageResource(name: "profile_clear", bundle: resourceBundle)

    /// The "profile_close" asset catalog image resource.
    static let profileClose = ImageResource(name: "profile_close", bundle: resourceBundle)

    /// The "profile_edit" asset catalog image resource.
    static let profileEdit = ImageResource(name: "profile_edit", bundle: resourceBundle)

    /// The "profile_like_active" asset catalog image resource.
    static let profileLikeActive = ImageResource(name: "profile_like_active", bundle: resourceBundle)

    /// The "profile_like_no_active" asset catalog image resource.
    static let profileLikeNoActive = ImageResource(name: "profile_like_no_active", bundle: resourceBundle)

    /// The "profile_nft_mock" asset catalog image resource.
    static let profileNftMock = ImageResource(name: "profile_nft_mock", bundle: resourceBundle)

    /// The "sort" asset catalog image resource.
    static let sort = ImageResource(name: "sort", bundle: resourceBundle)

    /// The "star_active" asset catalog image resource.
    static let starActive = ImageResource(name: "star_active", bundle: resourceBundle)

    /// The "star_no_active" asset catalog image resource.
    static let starNoActive = ImageResource(name: "star_no_active", bundle: resourceBundle)

}

// MARK: - Color Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// The "YP Background Universal" asset catalog color.
    static var ypBackgroundUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypBackgroundUniversal)
#else
        .init()
#endif
    }

    /// The "YP Black" asset catalog color.
    static var ypBlack: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypBlack)
#else
        .init()
#endif
    }

    /// The "YP Black Universal" asset catalog color.
    static var ypBlackUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypBlackUniversal)
#else
        .init()
#endif
    }

    /// The "YP Blue Universal" asset catalog color.
    static var ypBlueUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypBlueUniversal)
#else
        .init()
#endif
    }

    /// The "YP Gray Universal" asset catalog color.
    static var ypGrayUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypGrayUniversal)
#else
        .init()
#endif
    }

    /// The "YP Green Universal" asset catalog color.
    static var ypGreenUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypGreenUniversal)
#else
        .init()
#endif
    }

    /// The "YP Light Grey" asset catalog color.
    static var ypLightGrey: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypLightGrey)
#else
        .init()
#endif
    }

    /// The "YP Red Universal" asset catalog color.
    static var ypRedUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypRedUniversal)
#else
        .init()
#endif
    }

    /// The "YP White" asset catalog color.
    static var ypWhite: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypWhite)
#else
        .init()
#endif
    }

    /// The "YP White Universal" asset catalog color.
    static var ypWhiteUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypWhiteUniversal)
#else
        .init()
#endif
    }

    /// The "YP Yellow Universal" asset catalog color.
    static var ypYellowUniversal: AppKit.NSColor {
#if !targetEnvironment(macCatalyst)
        .init(resource: .ypYellowUniversal)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// The "YP Background Universal" asset catalog color.
    static var ypBackgroundUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypBackgroundUniversal)
#else
        .init()
#endif
    }

    /// The "YP Black" asset catalog color.
    static var ypBlack: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypBlack)
#else
        .init()
#endif
    }

    /// The "YP Black Universal" asset catalog color.
    static var ypBlackUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypBlackUniversal)
#else
        .init()
#endif
    }

    /// The "YP Blue Universal" asset catalog color.
    static var ypBlueUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypBlueUniversal)
#else
        .init()
#endif
    }

    /// The "YP Gray Universal" asset catalog color.
    static var ypGrayUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypGrayUniversal)
#else
        .init()
#endif
    }

    /// The "YP Green Universal" asset catalog color.
    static var ypGreenUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypGreenUniversal)
#else
        .init()
#endif
    }

    /// The "YP Light Grey" asset catalog color.
    static var ypLightGrey: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypLightGrey)
#else
        .init()
#endif
    }

    /// The "YP Red Universal" asset catalog color.
    static var ypRedUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypRedUniversal)
#else
        .init()
#endif
    }

    /// The "YP White" asset catalog color.
    static var ypWhite: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypWhite)
#else
        .init()
#endif
    }

    /// The "YP White Universal" asset catalog color.
    static var ypWhiteUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypWhiteUniversal)
#else
        .init()
#endif
    }

    /// The "YP Yellow Universal" asset catalog color.
    static var ypYellowUniversal: UIKit.UIColor {
#if !os(watchOS)
        .init(resource: .ypYellowUniversal)
#else
        .init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// The "YP Background Universal" asset catalog color.
    static var ypBackgroundUniversal: SwiftUI.Color { .init(.ypBackgroundUniversal) }

    /// The "YP Black" asset catalog color.
    static var ypBlack: SwiftUI.Color { .init(.ypBlack) }

    /// The "YP Black Universal" asset catalog color.
    static var ypBlackUniversal: SwiftUI.Color { .init(.ypBlackUniversal) }

    /// The "YP Blue Universal" asset catalog color.
    static var ypBlueUniversal: SwiftUI.Color { .init(.ypBlueUniversal) }

    /// The "YP Gray Universal" asset catalog color.
    static var ypGrayUniversal: SwiftUI.Color { .init(.ypGrayUniversal) }

    /// The "YP Green Universal" asset catalog color.
    static var ypGreenUniversal: SwiftUI.Color { .init(.ypGreenUniversal) }

    /// The "YP Light Grey" asset catalog color.
    static var ypLightGrey: SwiftUI.Color { .init(.ypLightGrey) }

    /// The "YP Red Universal" asset catalog color.
    static var ypRedUniversal: SwiftUI.Color { .init(.ypRedUniversal) }

    /// The "YP White" asset catalog color.
    static var ypWhite: SwiftUI.Color { .init(.ypWhite) }

    /// The "YP White Universal" asset catalog color.
    static var ypWhiteUniversal: SwiftUI.Color { .init(.ypWhiteUniversal) }

    /// The "YP Yellow Universal" asset catalog color.
    static var ypYellowUniversal: SwiftUI.Color { .init(.ypYellowUniversal) }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    /// The "YP Background Universal" asset catalog color.
    static var ypBackgroundUniversal: SwiftUI.Color { .init(.ypBackgroundUniversal) }

    /// The "YP Black" asset catalog color.
    static var ypBlack: SwiftUI.Color { .init(.ypBlack) }

    /// The "YP Black Universal" asset catalog color.
    static var ypBlackUniversal: SwiftUI.Color { .init(.ypBlackUniversal) }

    /// The "YP Blue Universal" asset catalog color.
    static var ypBlueUniversal: SwiftUI.Color { .init(.ypBlueUniversal) }

    /// The "YP Gray Universal" asset catalog color.
    static var ypGrayUniversal: SwiftUI.Color { .init(.ypGrayUniversal) }

    /// The "YP Green Universal" asset catalog color.
    static var ypGreenUniversal: SwiftUI.Color { .init(.ypGreenUniversal) }

    /// The "YP Light Grey" asset catalog color.
    static var ypLightGrey: SwiftUI.Color { .init(.ypLightGrey) }

    /// The "YP Red Universal" asset catalog color.
    static var ypRedUniversal: SwiftUI.Color { .init(.ypRedUniversal) }

    /// The "YP White" asset catalog color.
    static var ypWhite: SwiftUI.Color { .init(.ypWhite) }

    /// The "YP White Universal" asset catalog color.
    static var ypWhiteUniversal: SwiftUI.Color { .init(.ypWhiteUniversal) }

    /// The "YP Yellow Universal" asset catalog color.
    static var ypYellowUniversal: SwiftUI.Color { .init(.ypYellowUniversal) }

}
#endif

// MARK: - Image Symbol Extensions -

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    /// The "LaunchScreen" asset catalog image.
    static var launchScreen: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .launchScreen)
#else
        .init()
#endif
    }

    /// The "cart_add" asset catalog image.
    static var cartAdd: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cartAdd)
#else
        .init()
#endif
    }

    /// The "cart_delete" asset catalog image.
    static var cartDelete: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cartDelete)
#else
        .init()
#endif
    }

    /// The "cart_fill" asset catalog image.
    static var cartFill: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .cartFill)
#else
        .init()
#endif
    }

    /// The "close" asset catalog image.
    static var close: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .close)
#else
        .init()
#endif
    }

    /// The "favourites_default" asset catalog image.
    static var favouritesDefault: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .favouritesDefault)
#else
        .init()
#endif
    }

    /// The "favourites_pressed" asset catalog image.
    static var favouritesPressed: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .favouritesPressed)
#else
        .init()
#endif
    }

    /// The "profile_avatar_mock" asset catalog image.
    static var profileAvatarMock: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileAvatarMock)
#else
        .init()
#endif
    }

    /// The "profile_back" asset catalog image.
    static var profileBack: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileBack)
#else
        .init()
#endif
    }

    /// The "profile_chevron_forward" asset catalog image.
    static var profileChevronForward: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileChevronForward)
#else
        .init()
#endif
    }

    /// The "profile_clear" asset catalog image.
    static var profileClear: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileClear)
#else
        .init()
#endif
    }

    /// The "profile_close" asset catalog image.
    static var profileClose: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileClose)
#else
        .init()
#endif
    }

    /// The "profile_edit" asset catalog image.
    static var profileEdit: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileEdit)
#else
        .init()
#endif
    }

    /// The "profile_like_active" asset catalog image.
    static var profileLikeActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileLikeActive)
#else
        .init()
#endif
    }

    /// The "profile_like_no_active" asset catalog image.
    static var profileLikeNoActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileLikeNoActive)
#else
        .init()
#endif
    }

    /// The "profile_nft_mock" asset catalog image.
    static var profileNftMock: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .profileNftMock)
#else
        .init()
#endif
    }

    /// The "sort" asset catalog image.
    static var sort: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .sort)
#else
        .init()
#endif
    }

    /// The "star_active" asset catalog image.
    static var starActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .starActive)
#else
        .init()
#endif
    }

    /// The "star_no_active" asset catalog image.
    static var starNoActive: AppKit.NSImage {
#if !targetEnvironment(macCatalyst)
        .init(resource: .starNoActive)
#else
        .init()
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// The "LaunchScreen" asset catalog image.
    static var launchScreen: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .launchScreen)
#else
        .init()
#endif
    }

    /// The "cart_add" asset catalog image.
    static var cartAdd: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cartAdd)
#else
        .init()
#endif
    }

    /// The "cart_delete" asset catalog image.
    static var cartDelete: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cartDelete)
#else
        .init()
#endif
    }

    /// The "cart_fill" asset catalog image.
    static var cartFill: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .cartFill)
#else
        .init()
#endif
    }

    /// The "close" asset catalog image.
    static var close: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .close)
#else
        .init()
#endif
    }

    /// The "favourites_default" asset catalog image.
    static var favouritesDefault: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .favouritesDefault)
#else
        .init()
#endif
    }

    /// The "favourites_pressed" asset catalog image.
    static var favouritesPressed: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .favouritesPressed)
#else
        .init()
#endif
    }

    /// The "profile_avatar_mock" asset catalog image.
    static var profileAvatarMock: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileAvatarMock)
#else
        .init()
#endif
    }

    /// The "profile_back" asset catalog image.
    static var profileBack: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileBack)
#else
        .init()
#endif
    }

    /// The "profile_chevron_forward" asset catalog image.
    static var profileChevronForward: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileChevronForward)
#else
        .init()
#endif
    }

    /// The "profile_clear" asset catalog image.
    static var profileClear: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileClear)
#else
        .init()
#endif
    }

    /// The "profile_close" asset catalog image.
    static var profileClose: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileClose)
#else
        .init()
#endif
    }

    /// The "profile_edit" asset catalog image.
    static var profileEdit: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileEdit)
#else
        .init()
#endif
    }

    /// The "profile_like_active" asset catalog image.
    static var profileLikeActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileLikeActive)
#else
        .init()
#endif
    }

    /// The "profile_like_no_active" asset catalog image.
    static var profileLikeNoActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileLikeNoActive)
#else
        .init()
#endif
    }

    /// The "profile_nft_mock" asset catalog image.
    static var profileNftMock: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .profileNftMock)
#else
        .init()
#endif
    }

    /// The "sort" asset catalog image.
    static var sort: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .sort)
#else
        .init()
#endif
    }

    /// The "star_active" asset catalog image.
    static var starActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .starActive)
#else
        .init()
#endif
    }

    /// The "star_no_active" asset catalog image.
    static var starNoActive: UIKit.UIImage {
#if !os(watchOS)
        .init(resource: .starNoActive)
#else
        .init()
#endif
    }

}
#endif

// MARK: - Thinnable Asset Support -

@available(iOS 11.0, macOS 10.13, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ColorResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if AppKit.NSColor(named: NSColor.Name(thinnableName), bundle: bundle) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIColor(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    private convenience init?(thinnableResource: ColorResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.ShapeStyle where Self == SwiftUI.Color {

    private init?(thinnableResource: ColorResource?) {
        if let resource = thinnableResource {
            self.init(resource)
        } else {
            return nil
        }
    }

}
#endif

@available(iOS 11.0, macOS 10.7, tvOS 11.0, *)
@available(watchOS, unavailable)
extension ImageResource {

    private init?(thinnableName: Swift.String, bundle: Foundation.Bundle) {
#if canImport(AppKit) && os(macOS)
        if bundle.image(forResource: NSImage.Name(thinnableName)) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#elseif canImport(UIKit) && !os(watchOS)
        if UIKit.UIImage(named: thinnableName, in: bundle, compatibleWith: nil) != nil {
            self.init(name: thinnableName, bundle: bundle)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}

#if canImport(AppKit)
@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension AppKit.NSImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !targetEnvironment(macCatalyst)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    private convenience init?(thinnableResource: ImageResource?) {
#if !os(watchOS)
        if let resource = thinnableResource {
            self.init(resource: resource)
        } else {
            return nil
        }
#else
        return nil
#endif
    }

}
#endif

// MARK: - Backwards Deployment Support -

/// A color resource.
struct ColorResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog color resource name.
    fileprivate let name: Swift.String

    /// An asset catalog color resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize a `ColorResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

/// An image resource.
struct ImageResource: Swift.Hashable, Swift.Sendable {

    /// An asset catalog image resource name.
    fileprivate let name: Swift.String

    /// An asset catalog image resource bundle.
    fileprivate let bundle: Foundation.Bundle

    /// Initialize an `ImageResource` with `name` and `bundle`.
    init(name: Swift.String, bundle: Foundation.Bundle) {
        self.name = name
        self.bundle = bundle
    }

}

#if canImport(AppKit)
@available(macOS 10.13, *)
@available(macCatalyst, unavailable)
extension AppKit.NSColor {

    /// Initialize a `NSColor` with a color resource.
    convenience init(resource: ColorResource) {
        self.init(named: NSColor.Name(resource.name), bundle: resource.bundle)!
    }

}

protocol ACResourceInitProtocol {}
extension AppKit.NSImage: _ACResourceInitProtocol {}

@available(macOS 10.7, *)
@available(macCatalyst, unavailable)
extension ACResourceInitProtocol {

    /// Initialize a `NSImage` with an image resource.
    init(resource: ImageResource) {
        self = resource.bundle.image(forResource: NSImage.Name(resource.name))! as? Self
    }

}
#endif

#if canImport(UIKit)
@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIColor {

    /// Initialize a `UIColor` with a color resource.
    convenience init(resource: ColorResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}

@available(iOS 11.0, tvOS 11.0, *)
@available(watchOS, unavailable)
extension UIKit.UIImage {

    /// Initialize a `UIImage` with an image resource.
    convenience init(resource: ImageResource) {
#if !os(watchOS)
        self.init(named: resource.name, in: resource.bundle, compatibleWith: nil)!
#else
        self.init()
#endif
    }

}
#endif

#if canImport(SwiftUI)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Color {

    /// Initialize a `Color` with a color resource.
    init(_ resource: ColorResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SwiftUI.Image {

    /// Initialize an `Image` with an image resource.
    init(_ resource: ImageResource) {
        self.init(resource.name, bundle: resource.bundle)
    }

}
#endif
// swiftlint:enable file_length
