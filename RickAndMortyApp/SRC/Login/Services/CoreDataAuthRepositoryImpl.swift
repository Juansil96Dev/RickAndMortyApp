//
//  CoreDataAuthRepositoryImpl.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import CoreData

class CoreDataAuthRepositoryImpl: AuthRepository {
    
    private let context = CoreDataManager.shared.context
    
    func register(user: UserEntity, completion: @escaping (Result<Bool, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", user.email)
        
        context.perform {
            do {
                let existingUsers = try self.context.fetch(fetchRequest)
                if !existingUsers.isEmpty {
                    completion(.failure(AuthError.userAlreadyExists))
                    return
                }
                
                let newUser = User(context: self.context)
                newUser.name = user.name
                newUser.email = user.email
                newUser.password = user.password
                
                try self.context.save()
                completion(.success(true))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<UserEntity, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
        
        context.perform {
            do {
                if let userManagedObject = try self.context.fetch(fetchRequest).first,
                   let userEntity = UserEntity(managedObject: userManagedObject) {
                    completion(.success(userEntity))
                } else {
                    completion(.failure(AuthError.invalidCredentials))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
}
