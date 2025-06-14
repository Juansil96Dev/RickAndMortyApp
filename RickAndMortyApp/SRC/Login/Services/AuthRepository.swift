//
//  AuthRepository.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case userAlreadyExists
    case invalidCredentials
    case unknown

    var errorDescription: String? {
        switch self {
        case .userAlreadyExists: return "Ya existe un usuario con ese correo."
        case .invalidCredentials: return "Correo o contraseña incorrectos."
        case .unknown: return "Error desconocido."
        
        }
    }
}


protocol AuthRepository{
    
    func register(user: UserEntity, completion: @escaping (Result<Bool, Error>) -> Void)
    func login(email: String, password: String, completion: @escaping (Result<UserEntity, Error>) -> Void)
    
}
