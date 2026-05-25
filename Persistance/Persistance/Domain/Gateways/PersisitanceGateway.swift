//
//  PersisitanceGateway.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

protocol PersisitanceGateway {
    func getNotes() throws -> [Note]
    func addNote(_ note: Note) throws
    func deleteNote(_ note: Note) throws
    func updateNote(_ note: Note) throws
}
