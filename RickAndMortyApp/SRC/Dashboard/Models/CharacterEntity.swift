//
//  CharacterEntity.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//
import Foundation

enum CharacterStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"

    init(from string: String) {
        self = CharacterStatus(rawValue: string) ?? .unknown
    }
}

enum CharacterGender: String {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"

    init(from string: String) {
        self = CharacterGender(rawValue: string) ?? .unknown
    }
}

class CharacterEntity {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: String
    let location: String
    let imageURL: String
    let episodeCount: Int

    init(id: Int?, name: String?, status: String?, species: String?, type: String?,
         gender: String?, origin: String?, location: String?, imageURL: String?, episodeCount: Int?) {
        self.id = id ?? 0
        self.name = name ?? "Sin nombre"
        self.status = CharacterStatus(from: status ?? "")
        self.species = species ?? "Sin especie"
        self.type = type ?? "Sin tipo"
        self.gender = CharacterGender(from: gender ?? "")
        self.origin = origin ?? "Sin origen"
        self.location = location ?? "Sin localidad"
        self.imageURL = imageURL ?? "empty"
        self.episodeCount = episodeCount ?? 0
    }
}

