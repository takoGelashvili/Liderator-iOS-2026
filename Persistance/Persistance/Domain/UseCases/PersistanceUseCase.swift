//
//  PersistanceUseCase.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

protocol PersistanceUseCase {
    func getNotes() throws -> [Note]
    func addNote(_ note: Note) throws
    func deleteNote(_ note: Note) throws
    func updateNote(_ note: Note) throws
}

struct PersistanceUseCaseImpl: PersistanceUseCase {
    let gateway: PersisitanceGateway
    
    init(gateway: PersisitanceGateway) {
        self.gateway = gateway
    }
    
    func getNotes() throws -> [Note] {
        try gateway.getNotes()
    }
    
    func addNote(_ note: Note) throws {
        try gateway.addNote(note)
    }
    
    func deleteNote(_ note: Note) throws {
        try gateway.deleteNote(note)
    }
    
    func updateNote(_ note: Note) throws {
        try gateway.updateNote(note)
    }
}
