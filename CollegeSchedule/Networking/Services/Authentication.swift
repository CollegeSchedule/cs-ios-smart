import Foundation
import Alamofire

struct AuthenticationResult: Decodable {
    let access: Token
    let refresh: Token
}

struct AuthenticationInfoResult: Decodable {
    let id: Int
    let firstName: String
    let secondName: String
    let thirdName: String
    let avatar: String
    let status: AccountStatus
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

enum AccountStatus: String, Decodable {
    case created = "CREATED"
    case active = "ACTIVE"
    case locked = "LOCKED"
}

struct LoginParams: Encodable {
    let mail: String
    let password: String
}

struct InfoParams: Encodable {
    let id: String
    let token: String
}

extension EndPoint {
    static func login(mail: String, password: String) -> EndPoint<AuthenticationResult> {
        EndPoint<AuthenticationResult>(
            url: "/authentication",
            method: .put,
            params: [
                "mail": mail,
                "password": password
            ],
            headers: [
                "appToken": "6a16pg94wnr834gmosx39",
                "appSecret": "7viiuu2wkakandw2awvclp"
            ]
        )
    }
    
    static func info(id: Int, token: String) -> EndPoint<AuthenticationInfoResult> {
        EndPoint<AuthenticationInfoResult>(
            url: "/authentication",
            method: .get,
            params: [
                "id": id,
                "token": token
            ],
            headers: [
                "appToken": "6a16pg94wnr834gmosx39",
                "appSecret": "7viiuu2wkakandw2awvclp"
            ]
        )
    }
}
