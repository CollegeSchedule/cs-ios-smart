import Foundation

struct Response<T: Decodable>: Decodable {
    let status: Bool
    let data: T? = nil
    let error: Error? = nil
}