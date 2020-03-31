import Foundation
import Alamofire

struct EndPoint<Result: Decodable> {
    let url: String
    var method: HTTPMethod = .get
    
    var params: Parameters? = nil
    var headers: HTTPHeaders? = nil
}

extension Session {
    func request<Result: Decodable>(_ endpoint: EndPoint<Result>, completionHandler: @escaping (APIResponse<Result>) -> Void) {
        AF.request(
            "http://80.80.80.101:5000\(endpoint.url)",
            method: endpoint.method,
            parameters: endpoint.params,
            encoding: JSONEncoding.default,
            headers: endpoint.headers
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
    
    func test() {
//        AF.request(
//            "http://80.80.80.101:5000/authentication/",
//            method: .get,
//            parameters: TestParams(id: 1, token: ""),
//            encoder: JSONParameterEncoder.default
//        ) { result in
//
//        }
        
        AF.request(.login(mail: "", password: "")) { result in
            
        }
    }
}

struct TestParams: Encodable {
    let id: Int
    let token: String
}

