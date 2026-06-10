//
//  WelcomeScreenView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var stayLoggedIn: Bool = false

    var body: some View {
        VStack(spacing: 20) {
            HeaderView()
            Group {
                TextField("Username",
                          text: $username)
                TextField("Password",
                          text: $password)
            }
            .textFieldStyle(.bog)
            
            Toggle("Stay logged in", isOn: $stayLoggedIn)
                .tint(.orange)
                .foregroundStyle(.orange)
            Button("LOG IN", systemImage: "person") {
                print("LOG IN")
            }
            .buttonStyle(.primary)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    WelcomeScreenView()
}
