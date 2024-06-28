import Foundation

struct NFTRequest: NetworkRequest {
    var httpMethod: HttpMethod {
        return .get
    }
    var authToken: String? {
        RequestConstants.token
    }
    let id: String
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/nft/\(id)")
    }
}
