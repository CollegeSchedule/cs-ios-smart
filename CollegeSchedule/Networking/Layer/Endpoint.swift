import Foundation

typealias EndpointData = [String: Any]

struct Endpoint {
    let path: String

    var method: RequestMethod = RequestMethod.get
    var query: EndpointData? = nil
    var body: EndpointData? = nil
    var headers: EndpointData? = nil
}

extension Endpoint {
    // todo: token authentication
    // todo: application authentication

    func generateURLRequest() -> URLRequest? {
        var components: URLComponents = URLComponents()

        // todo: ENV
        components.scheme = "http"
        components.host = "localhost"
        components.port = 5000
        components.path = self.path

        if let query = self.query {
            components.queryItems = query.map { key, value in
                URLQueryItem(name: key, value: String(describing: value))
            }
        }

        guard let url = components.url else {
            return nil
        }

        var request: URLRequest = URLRequest(url: url)

        request.httpMethod = self.method.rawValue

        if let body = self.body {
            // todo: refactor
            request.httpBody = try! JSONSerialization.data(withJSONObject: body)
        }

        if let headers = self.headers {
            headers.forEach { key, value in
                request.setValue(String(describing: value), forHTTPHeaderField: key)
            }
        }

        return request
    }
}