//
//  CharactersRepository.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-12.
//

protocol CharactersRepository {
    func getCharacters(completion: @escaping ([Character]) -> Void)
}
