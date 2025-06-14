//
//  HttpClient.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import Foundation
import ObjectMapper

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case PATCH
    case DELETE
}

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
    case custom(message: String, code: Int?)
    case unknown
}

protocol APIClientProtocol {
    func requestRaw(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        completion: @escaping (Result<Data, APIError>) -> Void
    )
}

class APIClient: APIClientProtocol {
    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func requestRaw(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Data? = nil,
        completion: @escaping (Result<Data, APIError>) -> Void
    ) {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        headers?.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        request.httpBody = body

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            let statusCode = httpResponse.statusCode
            if (200...299).contains(statusCode) {
                completion(.success(data))
            } else {
                if let jsonString = String(data: data, encoding: .utf8),
                   let apiError = Mapper<APIErrorResponse>().map(JSONString: jsonString) {
                    completion(.failure(.custom(message: apiError.message ?? "Error desconocido", code: apiError.code)))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}


class APIErrorResponse: Mappable {
    var message: String?
    var code: Int?

    required init?(map: Map) {}

    func mapping(map: Map) {
        message <- map["error"]
        code    <- map["code"]
    }
}
