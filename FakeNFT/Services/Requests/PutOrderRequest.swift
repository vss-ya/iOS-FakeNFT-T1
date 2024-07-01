
import Foundation

struct PutOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/orders/1")
    }
    var httpMethod: HttpMethod {
        return .put
    }
    var authToken: String? {
       RequestConstants.token
    }
    var dto: Encodable?
    
    init(nfts: [String]) {
        let nftsString = nfts.joined(separator: ",")
        let bodyString = nfts.isEmpty ? "" : "nfts=\(nftsString)"
        self.dto = bodyString.data(using: .utf8)
    }
}

