import Foundation

extension Endpoint {
    static func authenticationInfo(id: Int, token: String, mail: String) -> Endpoint {
        let query: [String: Any] = [
            "id": id,
            "token": token,
            "mail": mail
        ]

        return Endpoint(path: "/authentication/", method: .get, query: query)
    }

    static func authenticationSignIn(mail: String, password: String) -> Endpoint {
        let body: [String: Any] = [
            "mail": mail,
            "password": password
        ]

        return Endpoint(path: "/authentication/", method: .put, body: body)
    }

    static func authenticationSignUp(id: Int, token: String, mail: String, password: String) -> Endpoint {
        let body: [String: Any] = [
            "id": id,
            "token": token,
            "mail": mail,
            "password": password
        ]

        return Endpoint(path: /authenticationSignIn(mail: <#T##String##Swift.String#>, password: <#T##String##Swift.String#>))
    }
}