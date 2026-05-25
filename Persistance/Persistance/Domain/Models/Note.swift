//
//  Note.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

import Foundation

struct Note {
    let id: UUID
    var title: String
    let createdAt: Date
    
    init(id: UUID, title: String, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.createdAt = createdAt
    }
}
