import Foundation
import Alamofire

enum AuthenticationType: Int {
    case none
    case application
    case token
}

struct EndPoint<Result: Decodable> {
    let url: String
    var method: HTTPMethod = .get
    
    var params: Parameters? = nil
    var headers: HTTPHeaders? = nil
    var authenticationType: AuthenticationType = .none
}

extension Session {
    func request<Result: Decodable>(_ endpoint: EndPoint<Result>, completionHandler: @escaping (APIResponse<Result>) -> Void) {
        AF.request(
            "http://172.20.10.2:5000\(endpoint.url)",
            method: endpoint.method,
            parameters: endpoint.params,
            encoding: JSONEncoding.default,
            headers: [
                "appToken": "e1e12875-4048-4031-9fdb-51aba0f2f5f5",
                "appSecret": "9363d3de-1671-4888-89a9-a78d57721131",
            ]
        ).responseDecodable(of: APIResponse<Result>.self) { response in
            switch response.result {
            case .success(let data):
                completionHandler(data)
                
                break
            case .failure(let error):
                break
            }
        }
    }
}
