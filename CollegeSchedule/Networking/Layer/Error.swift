import Foundation

struct Error: Decodable {
    let code: Int
    let message: String
    let description: String
}
