//
//  NoteSwiftDataModel.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

internal import SwiftData
import Foundation

@Model
final class NoteSwiftDataModel {
    var id: UUID
    var title: String
    var createdAt: Date
    
    init(id: UUID, title: String, createdAt: Date) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
    
    var toModel: Note {
        Note(
            id: id,
            title: title,
            createdAt: createdAt
        )
    }
}
