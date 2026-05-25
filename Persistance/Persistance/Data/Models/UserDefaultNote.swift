//
//  UserDefaultNote.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

import Foundation

struct UserDefaultNote: Codable {
    let id: UUID
    let title: String
    let createdAt: Date
    
    init(from note: Note) {
        self.id = note.id
        self.title = note.title
        self.createdAt = note.createdAt
    }
    
    var toModel: Note {
        Note(
            id: id,
            title: title,
            createdAt: createdAt
        )
    }
}
