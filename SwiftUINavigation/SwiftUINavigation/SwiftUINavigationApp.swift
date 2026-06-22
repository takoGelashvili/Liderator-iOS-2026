//
//  SwiftUINavigationApp.swift
//  SwiftUINavigation
//
//  Created by Tamar Gelashvili on 22/06/2026.
//

import SwiftUI

@main
struct SwiftUINavigationApp: App {
    @State var coordinator: Coordinator = .init()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                Tab {
                    NavigationStack(path: $coordinator.path) {
                        ContentView()
                            .navigationDestination(for: Coordinator.Routes.self) { route in
                                switch route {
                                case .blue: ColorView(color: .blue, navigateTo: .orange)
                                case .pink: ColorView(color: .pink, navigateTo: .orange)
                                case .orange: ColorView(color: .orange, navigateTo: .orange)
                                case .cyan: ColorView(color: .cyan, navigateTo: .orange)
                                case .red: ColorView(color: .red, navigateTo: .orange)
                                case .indigo: ColorView(color: .indigo, navigateTo: .orange)
                                }
                            }
                    }
                    .environment(coordinator)
                } label: {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                
                Tab {
                    SecondTab()
                } label: {
                    Text("Second")
                    Image(systemName: "phone.fill")
                }
                .badge(5)
            }
            .tint(.orange)
            .tabViewStyle(.tabBarOnly)
        }
    }
}

struct SecondTab: View {
    var body: some View {
        Text("Second tab")
    }
}

@Observable
final class Coordinator {
    var path = NavigationPath()
    
    enum Routes: String, Hashable {
        case blue
        case pink
        case orange
        case cyan
        case red
        case indigo
        
        var color: Color {
            switch self {
            case .blue: return .blue
            case .pink: return .pink
            case .orange: return .orange
            case .cyan: return .cyan
            case .red: return .red
            case .indigo: return .indigo
            }
        }
    }
    
    func push(_ route: Routes) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
