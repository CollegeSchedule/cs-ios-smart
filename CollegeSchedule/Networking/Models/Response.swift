import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let status: Bool
    let data: T?
    let error: APIError?
}
