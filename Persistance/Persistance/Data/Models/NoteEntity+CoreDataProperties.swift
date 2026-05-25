//
//  NoteEntity+CoreDataProperties.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//
//

public import Foundation
public import CoreData


public typealias NoteEntityCoreDataPropertiesSet = NSSet

extension NoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteEntity> {
        return NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var createdAt: Date?

}

extension NoteEntity : Identifiable {
    
}

extension NoteEntity {
    var toModel: Note? {
        guard let id,
              let title,
              let createdAt else { return nil }
        
        return Note(
            id: id,
            title: title,
            createdAt: createdAt
        )
    }
}
