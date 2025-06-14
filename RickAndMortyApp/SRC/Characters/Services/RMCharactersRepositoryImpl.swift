//
//  RMCharactersRepositoryImpl.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

import Foundation
import ObjectMapper

class RMCharactersRepositoryImpl : CharactersRepository {
    
    private let apiClient = APIClient(baseURL: URL(string: "https://rickandmortyapi.com/api/")!)

    func getCharacters(page: Int, completion: @escaping (Result<[CharacterEntity], APIError>) -> Void) {
        let endpoint = "character?page=\(page)"
        apiClient.requestRaw(endpoint: endpoint, method: .GET, headers: nil, body: nil) { result in
            switch result {
            case .success(let data):
                if let jsonString = String(data: data, encoding: .utf8),
                   let response = Mapper<CharacterResponse>().map(JSONString: jsonString),
                   let models = response.results {
                    let entities = models.map { $0.toEntity() }
                    completion(.success(entities))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
