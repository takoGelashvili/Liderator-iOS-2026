//
//  CoreDataGateway.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

internal import CoreData
struct CoreDataGateway: PersisitanceGateway {
    func getNotes() throws -> [Note] {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        let fetched = try CoreDataManager.shared.context.fetch(
            fetchRequest
        )
        
        return fetched.compactMap { $0.toModel }
    }
    
    func addNote(_ note: Note) throws {
        let noteEntity = NoteEntity(
            context: CoreDataManager.shared.context
        )
        
        noteEntity.id = note.id
        noteEntity.title = note.title
        noteEntity.createdAt = note.createdAt
        
        try CoreDataManager.shared.save()
    }
    
    func deleteNote(_ note: Note) throws {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        let fetched = try CoreDataManager.shared.context.fetch(
            fetchRequest
        )
        
        let toDelete = fetched.first(where: { $0.id == note.id })!
        
        CoreDataManager.shared.context.delete(toDelete)
        try CoreDataManager.shared.save()
    }
    
    func updateNote(_ note: Note) throws {
        let fetchRequest: NSFetchRequest<NoteEntity> = NoteEntity.fetchRequest()
        
        let fetched = try CoreDataManager.shared.context.fetch(
            fetchRequest
        )
        
        let toUpdate = fetched.first(where: { $0.id == note.id })!
        toUpdate.title = note.title
        
        try CoreDataManager.shared.save()
    }
}
