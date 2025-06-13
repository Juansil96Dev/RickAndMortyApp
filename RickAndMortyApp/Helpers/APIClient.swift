//
//  HttpClient.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import Foundation

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
    case unknown
}

protocol APIClientProtocol {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]?,
        body: Data?,
        completion: @escaping (Result<T, APIError>) -> Void
    )
}

class APIClient: APIClientProtocol {

    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        body: Data? = nil,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        if let headers = headers {
            headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        }

        if let body = body {
            request.httpBody = body
        }

        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch let decodeError {
                completion(.failure(.decodingFailed(decodeError)))
            }

        }.resume()
    }
}
