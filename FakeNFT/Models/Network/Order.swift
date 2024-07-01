import Foundation

struct Order: Decodable, Encodable {
    let id: String
    let nfts: [String]
}
