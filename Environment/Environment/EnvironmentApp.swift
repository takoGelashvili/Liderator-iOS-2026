//
//  EnvironmentApp.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI
import Observation

@main
struct EnvironmentApp: App {
    @State var appTheme = AppTheme()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(appTheme)
                .environment(\.colorScheme, appTheme.isDark ? .dark : .light)
        }
    }
}

extension EnvironmentValues {
    @Entry var count: Int = 12
}

@Observable
final class AppTheme {
    var isDark: Bool = true
    var accentColor: AccentColor = .pink
}

enum AccentColor: String, CaseIterable, Identifiable {
    case pink
    case yellow
    case green
    case blue
    case red
    case purple
    case orange
    case cyan
    
    var id: String {
        self.rawValue
    }
    
    var color: Color {
        switch self {
        case .pink: return .pink
        case .yellow: return .yellow
        case .green: return .green
        case .blue: return .blue
        case .red: return .red
        case .purple: return .purple
        case .orange: return .orange
        case .cyan: return .cyan
        }
    }
}
