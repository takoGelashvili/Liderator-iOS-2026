//
//  SwiftUIPersistanceApp.swift
//  SwiftUIPersistance
//
//  Created by Tamar Gelashvili on 24/06/2026.
//

import SwiftUI
import SwiftData

@main
struct SwiftUIPersistanceApp: App {
    
    private var modelContainer: ModelContainer = {
        let schema = Schema([
            Student.self,
            Faculty.self,
            Course.self,
            CourseGrade.self
        ])
          
        let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: configuration)
        } catch {
            fatalError(error.localizedDescription)
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(modelContainer)
        }
    }
}
