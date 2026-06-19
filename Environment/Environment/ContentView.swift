//
//  ContentView.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct ContentView: View {
    @State var isSettingsPresented: Bool = false
    @Environment(\.colorScheme) var colorScheme
    @Environment(AppTheme.self) var theme
    @Environment(\.count) var count
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button {
                isSettingsPresented = true
            } label: {
                Image(systemName: "gearshape.fill")
                    .font(.largeTitle)
            }
            
            Text("\(count)")
                .font(.largeTitle)
        }
        .padding()
        .preferredColorScheme(colorScheme)
        .sheet(isPresented: $isSettingsPresented) {
            SettingsView()
                .environment(\.count, 40)
        }
        .tint(theme.accentColor.color)
    }
}

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(AppTheme.self) var theme
    @Environment(\.count) var count

    var body: some View {
        VStack {
            let bindableTheme = Bindable(theme)
            Toggle(isOn: bindableTheme.isDark) {
                Text("Toggle color scheme")
            }
            
            Picker("Pick accent color", selection: bindableTheme.accentColor, content: {
                ForEach(AccentColor.allCases) { col in
                    Text(col.rawValue).tag(col)
                }
            })
            
            Text("\(count)")
                .font(.largeTitle)
            
            CountView()
        }
        .environment(\.count, 60)
        .preferredColorScheme(colorScheme)
    }
}

struct CountView: View {
    @Environment(\.count) var count

    var body: some View {
        Text("COUNT IS \(count)")
    }
}

#Preview {
    @Previewable @State var appTheme = AppTheme()

    ContentView()
        .environment(\.colorScheme, appTheme.isDark ? .dark : .light)
        .environment(appTheme)
}
