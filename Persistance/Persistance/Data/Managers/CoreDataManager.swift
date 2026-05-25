//
//  CoreDataManager.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

internal import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(
            name: "NoteDS"
        )
        
        container.loadPersistentStores { _, error  in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func save() throws {
        try container.viewContext.save()
    }
}
