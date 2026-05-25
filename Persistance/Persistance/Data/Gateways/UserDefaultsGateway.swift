//
//  UserDefaultsGateway.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

import Foundation

struct UserDefaultsGatewayImpl: PersisitanceGateway {
    let key: String = "notes"
    
    init() {
        let data = UserDefaults.standard.data(forKey: key)
        if data == nil {
            let notes: [UserDefaultNote] = []
            let encoded = try! JSONEncoder().encode(notes)

            UserDefaults.standard.set(encoded, forKey: key)
        }        
    }
    
    func getNotes() throws -> [Note] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw InvalidDataError()
        }
        
        let notes: [Note] = try JSONDecoder().decode(
            [UserDefaultNote].self,
            from: data
        ).map { $0.toModel }
        
        return notes
    }
    
    func addNote(_ note: Note) throws {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw InvalidDataError()
        }
        
        var notes: [UserDefaultNote] = try JSONDecoder().decode(
            [UserDefaultNote].self,
            from: data
        )
        
        notes.append(UserDefaultNote(from: note))
        
        let encoded = try JSONEncoder().encode(notes)
        
        UserDefaults.standard.set(encoded, forKey: key)
    }
    
    func deleteNote(_ note: Note) throws {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw InvalidDataError()
        }
        
        var notes: [UserDefaultNote] = try JSONDecoder().decode(
            [UserDefaultNote].self,
            from: data
        )
        
        notes.removeAll(where: { $0.id == note.id })
        
        let encoded = try JSONEncoder().encode(notes)
        UserDefaults.standard.set(encoded, forKey: key)
    }
    
    func updateNote(_ note: Note) throws {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            throw InvalidDataError()
        }
        
        var notes: [UserDefaultNote] = try JSONDecoder().decode(
            [UserDefaultNote].self,
            from: data
        )
        
        let index = notes.firstIndex(where: { $0.id == note.id })!
        notes[index] = UserDefaultNote(from: note)
        
        let encoded = try JSONEncoder().encode(notes)
        UserDefaults.standard.set(encoded, forKey: key)
    }
}

struct InvalidDataError: Error {
    var errorDescription: String? {
        "Invalid data"
    }
}
