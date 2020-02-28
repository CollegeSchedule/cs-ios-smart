import Foundation
import Alamofire

struct EndPoint<T: Decodable> {
    let url: String
    var method: HTTPMethod = .get
    
    var params: Parameters? = nil
    var headers: HTTPHeaders? = nil
}

extension Session {
    func request<T: Decodable>(_ endpoint: EndPoint<T>, completionHandler: @escaping (AFDataResponse<APIResponse<T>>) -> Void) {
        AF.request(
            "http://80.80.80.101:5000\(endpoint.url)",
            method: endpoint.method,
            parameters: endpoint.params,
            encoding: JSONEncoding.default,
            headers: endpoint.headers
        ).responseDecodable(of: APIResponse<T>.self, completionHandler: completionHandler)
    }
}
