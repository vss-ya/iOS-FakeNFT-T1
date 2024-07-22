import Foundation

struct Nft: Decodable {

    let id: String
    let name: String
    let images: [URL]
    let rating: Int
    let price: Float
    let createdAt: String
    let description: String
    let author: String

}
