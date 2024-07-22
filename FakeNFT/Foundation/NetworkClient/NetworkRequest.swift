import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
    var authToken: String? { get }
    var dto: Encodable? { get }
    var httpBody: Data? { get }
}

// default values
extension NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var dto: Encodable? { nil }
    var httpBody: Data? { nil }
    var authToken: String? { "7e55487c-2d33-4c4a-8601-07943684c86d" }
}
