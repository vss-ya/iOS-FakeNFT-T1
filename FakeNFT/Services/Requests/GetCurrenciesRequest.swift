import Foundation

struct GetCurrenciesRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/currencies")
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
