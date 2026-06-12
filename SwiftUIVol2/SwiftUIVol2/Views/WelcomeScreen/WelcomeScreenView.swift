//
//  WelcomeScreenView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State private var stayLoggedIn: Bool = false
    @State private var isErrorShowing: Bool = false
    
    @State var viewModel: WelcomeViewModel

    var body: some View {
        VStack(spacing: 20) {
            HeaderView()
                TextField("Username",
                          text: $viewModel.state.username)
                .textFieldStyle(.bog)
                TextField("Password",
                          text: $viewModel.state.password)
                .textFieldStyle(viewModel.state.isTextFieldInErrorState ? .bogError : .bog)
                .modifier(LetterCounterModifier(count: viewModel.state.password.count))
            
            Toggle("Stay logged in", isOn: $stayLoggedIn)
                .tint(.orange)
                .foregroundStyle(.orange)
            Button("LOG IN", systemImage: "person") {
                Task {
                    await viewModel.didTapLogin()
                }
            }
            .buttonStyle(.primary)
            Button("Sign Up") {
                Task {
                    await viewModel.didTapSignUp()
                }
                withAnimation { isErrorShowing = true }

                Task {
                    try? await Task.sleep(for: .seconds(2))
                    withAnimation { isErrorShowing = false }
                }
            }
            .buttonStyle(.secondary)
        }
        .modifier(ErrorBanner(
            errorText: "Cannot sign up",
            isErrorShowing: $isErrorShowing)
        )
        .padding(.horizontal, 20)
    }
}

struct LetterCounterModifier: ViewModifier {
    let count: Int
    let maxCount: Int = 20
    
    func body(content: Content) -> some View {
        VStack {
            content
            HStack {
                Text("\(count)/\(maxCount)")
                    .foregroundStyle(.gray)
                    .padding(.leading, 5)
                Spacer()
            }
        }
    }
}

struct ErrorBanner: ViewModifier {
    let errorText: String
    @Binding var isErrorShowing: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
            VStack {
                if isErrorShowing {
                    Text(errorText)
                        .font(.title3)
                        .bold()
                        .padding(30)
                        .padding(.horizontal, 40)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.red.opacity(0.9))
                        }
                        .transition(.push(from: .top))
                }
                Spacer()
            }
        }
    }
}

#Preview {
    WelcomeScreenView(viewModel: WelcomeViewModelImpl())
}
