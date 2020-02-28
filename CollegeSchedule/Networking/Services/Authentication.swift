import Foundation
import Alamofire

struct AuthenticationResult: Decodable {
    let access: Token
    let refresh: Token
}

struct Token: Decodable {
    let token: String
    let type: TokenType
    let lifetime: Int
    let createdAt: Int
}

enum TokenType: String, Decodable {
    case access = "ACCESS"
    case refresh = "REFRESH"
}

extension EndPoint {
    static func login(mail: String, password: String) -> EndPoint<AuthenticationResult> {
        EndPoint<AuthenticationResult>(
            url: "/authentication",
            method: .put,
            params: [:],
            headers: [:]
        )
    }
}
