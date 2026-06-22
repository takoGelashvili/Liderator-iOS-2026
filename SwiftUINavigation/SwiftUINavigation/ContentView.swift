//
//  ContentView.swift
//  SwiftUINavigation
//
//  Created by Tamar Gelashvili on 22/06/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationLink(
                value: Coordinator.Routes.blue) {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.blue)
                        .frame(width: 100, height: 100)
                }
            
            NavigationLink(
                value: Coordinator.Routes.red) {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.red)
                        .frame(width: 100, height: 100)
                }
            
            NavigationLink(
                value: Coordinator.Routes.indigo) {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.indigo)
                        .frame(width: 100, height: 100)
                }
            
            NavigationLink(
                value: Coordinator.Routes.pink) {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.pink)
                        .frame(width: 100, height: 100)
                }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}

struct ColorView: View {
    let color: Color
    let navigateTo: Coordinator.Routes
    
    @State var isHeartFilled = false
    @Environment(\.dismiss) var dismiss
    @Environment(Coordinator.self) var coordinator
    
    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            
            VStack {
                NavigationLink(navigateTo.rawValue, value: navigateTo)
                    .foregroundStyle(.black)
                
                Button("Pop to root") {
                    coordinator.popToRoot()
                }
            }
        }
        .modifier(NavigationBarModifer(
            isHeartFilled: $isHeartFilled,
            onBackButtonTap: {
                dismiss()
            }
        ))
    }
}

struct NavigationBarModifer: ViewModifier {
    @Binding var isHeartFilled: Bool
    let onBackButtonTap: () -> Void
    
    func body(content: Content) -> some View {
        content
            .navigationTitle("Lallalala")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Text("         ")
                        .onTapGesture {
                            onBackButtonTap()
                        }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: isHeartFilled ? "heart.fill" : "heart")
                        .onTapGesture {
                            isHeartFilled.toggle()
                        }
                }
//                ToolbarItem(placement: .bottomBar) {
//                    Image(systemName: "square.and.arrow.up.circle.fill")
//                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.red, for: .bottomBar)
            .toolbarBackgroundVisibility(.visible, for: .bottomBar)
        
            .toolbarBackground(.purple, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden()
    }
}
