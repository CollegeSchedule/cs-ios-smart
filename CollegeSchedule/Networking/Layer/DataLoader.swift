import Foundation

typealias RequestHandler<T: Decodable> = ((Response<T>) -> Void)?

class DataLoader {
    private static var urlSession: URLSession = URLSession(configuration: .default)
    private static var jsonDecoder: JSONDecoder = JSONDecoder()

    static func request<T: Decodable>(_ endpoint: Endpoint, _ handler: RequestHandler<T>) -> URLSessionDataTask? {
        guard let request = endpoint.generateURLRequest() else {
            // todo: add error handling
            return nil
        }

        return Self.urlSession.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                handler?(try! Self.jsonDecoder.decode(Response<T>.self, from: data))
            }
        }
    }
}