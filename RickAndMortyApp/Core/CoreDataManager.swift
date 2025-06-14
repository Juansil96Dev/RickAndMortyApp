//
//  CoreDataManager.swift
//  RickAndMortyApp
//
//  Created by Juan Gonzalez on 2025-06-13.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "RickAndMortyApp")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Error cargando Core Data: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() throws {
        if context.hasChanges {
            try context.save()
        }
    }
}
