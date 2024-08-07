import UIKit

extension UIColor {
    // Creates color from a hex string
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let alpha, red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (alpha, red, green, blue) = (255, 0, 0, 0)
        }
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: CGFloat(alpha) / 255
        )
    }

    // Primary Colors
    static let primary = UIColor(named: "YP White") ?? UIColor.white

    // Secondary Colors
    static let secondary = UIColor(red: 255 / 255, green: 193 / 255, blue: 7 / 255, alpha: 1.0)

    // Background Colors
    static let background = UIColor.systemBackground

    // Text Colors
    static let textPrimary = UIColor(named: "YP Black") ?? UIColor.black
    static let textSecondary = UIColor.gray
    static let textOnPrimary = UIColor.white
    static let textOnSecondary = UIColor.black

    static let yaBlackLight = UIColor(named: "YP Black") ?? UIColor.black
    static let yaBlackDark = UIColor.white
    static let yaBlackUniversal = UIColor(named: "YP Black Universal") ?? UIColor(hexString: "#1A1B22")
    static let yaLightGrayLight = UIColor(named: "YP Light Grey") ?? UIColor(hexString: "#F7F7F8")
    static let yaGreenUniversal = UIColor(named: "YP Green Universal") ?? UIColor(hexString: "#1C9F00")
    static let yaRedUniversal = UIColor(named: "YP Red Universal") ?? UIColor(hexString: "#F56B6C")
    static let yaBlueUniversal = UIColor(named: "YP Blue Universal") ?? UIColor(hexString: "#0A84FF")
    static let yaLightGrayDark = UIColor(hexString: "#2C2C2E")
    static let yaForAlert = UIColor(hexString: "#F2F2F2")

    static let segmentActive = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaBlackDark
        : .yaBlackLight
    }

    static let segmentInactive = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaLightGrayDark
        : .yaLightGrayLight
    }

    static let closeButton = UIColor { traits in
        return traits.userInterfaceStyle == .dark
        ? .yaBlackDark
        : .yaBlackLight
    }
}
