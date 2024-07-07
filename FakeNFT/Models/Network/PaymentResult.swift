import Foundation

struct PaymentResult: Decodable {
    let success: Bool
    let orderId: String
    let id: String
}
