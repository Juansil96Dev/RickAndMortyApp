//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import ObjectMapper
import Foundation

class CharacterModel: Mappable {
    var id: Int?
    var name: String?
    var status: String?
    var species: String?
    var type: String?
    var gender: String?
    var originName: String?
    var locationName: String?
    var image: String?
    var episode: [String] = []

    required init?(map: Map) {}

    func mapping(map: Map) {
        id           <- map["id"]
        name         <- map["name"]
        status       <- map["status"]
        species      <- map["species"]
        type         <- map["type"]
        gender       <- map["gender"]
        originName   <- map["origin.name"]
        locationName <- map["location.name"]
        image        <- map["image"]
        episode      <- map["episode"]
    }

    func toEntity() -> CharacterEntity {
        return CharacterEntity(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: originName,
            location: locationName,
            imageURL: image,
            episodeCount: episode.count
        )
    }
}
