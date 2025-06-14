//
//  CharacterResponse.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import ObjectMapper

class CharacterResponse: Mappable {
    var results: [CharacterModel]?

    required init?(map: Map) {}

    func mapping(map: Map) {
        results <- map["results"]
    }
}
