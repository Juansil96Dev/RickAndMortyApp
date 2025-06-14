//
//  UserEntity.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import Foundation

class UserEntity {
    let name: String
    let email: String
    let password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    convenience init?(managedObject: User) {
        guard let name = managedObject.name,
              let email = managedObject.email,
              let password = managedObject.password else {
            return nil
        }
        self.init(name: name, email: email, password: password)
    }
}
