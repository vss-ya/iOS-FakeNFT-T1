import Foundation

enum SortOption: String, CaseIterable {
    case byPrice
    case byRating
    case byName

    var localizedString: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
