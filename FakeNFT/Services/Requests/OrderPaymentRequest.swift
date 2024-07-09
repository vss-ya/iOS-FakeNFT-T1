import Foundation

struct OrderPaymentRequest: NetworkRequest {
    var endpoint: URL?
    var httpMethod: HttpMethod {
        return .get
    }
    var authToken: String? {
        RequestConstants.token
    }
    var dto: Encodable? {
        return nil
    }

    init(currencyId: String) {
        endpoint = URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1/payment/" + currencyId)
    }
}
