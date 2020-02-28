import Foundation

struct APIError: Decodable {
    let code: Int
    let message: String
    let description: String
}
