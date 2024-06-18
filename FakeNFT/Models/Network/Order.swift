import Foundation

struct Order: Decodable {
    let id: String
    let nfts: [Nft]
}
