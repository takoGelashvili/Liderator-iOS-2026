//
//  SwiftDataManager.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

internal import SwiftData

final class SwiftDataManager {
    static let shared = SwiftDataManager()
    
    private let container: ModelContainer
    
    private init() {
        container = try! ModelContainer(for: NoteSwiftDataModel.self)
    }
    
    var context: ModelContext {
        container.mainContext
    }
    
    func save() throws {
        try container.mainContext.save()
    }
}
