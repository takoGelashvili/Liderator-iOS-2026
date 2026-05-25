//
//  SwiftDateGateway.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

internal import SwiftData
import Foundation

struct SwiftDateGateway: PersisitanceGateway {
    func getNotes() throws -> [Note] {
        try SwiftDataManager.shared.context.fetch(
            FetchDescriptor<NoteSwiftDataModel>(
                sortBy: [
                    SortDescriptor(\.createdAt, order: .forward)
                ]
            )
        ).map { $0.toModel }
    }
    
    func addNote(_ note: Note) throws {
        let noteEntity = NoteSwiftDataModel(
            id: note.id,
            title: note.title,
            createdAt: note.createdAt
        )
        
        SwiftDataManager.shared.context.insert(noteEntity)
        try SwiftDataManager.shared.save()
    }
    
    func deleteNote(_ note: Note) throws {
        let notes = try SwiftDataManager.shared.context.fetch(
            FetchDescriptor<NoteSwiftDataModel>())
        
        let toDelete = notes.first(where: { $0.id == note.id })!
        
        SwiftDataManager.shared.context.delete(toDelete)
        try SwiftDataManager.shared.save()
    }
    
    func updateNote(_ note: Note) throws {
        let notes = try SwiftDataManager.shared.context.fetch(
            FetchDescriptor<NoteSwiftDataModel>())
        
        let toUpdate = notes.first(where: { $0.id == note.id })!
        
        toUpdate.title = note.title
        try SwiftDataManager.shared.save()
    }
}
