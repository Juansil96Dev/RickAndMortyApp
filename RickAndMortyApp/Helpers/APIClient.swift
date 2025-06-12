//
//  HttpClient.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

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


