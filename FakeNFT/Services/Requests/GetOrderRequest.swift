import Foundation

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod {
        return .get
    }
    var authToken: String? {
       RequestConstants.token
    }
    var dto: Encodable? {
        return nil
    }
}
