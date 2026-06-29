//
//  SwiftUIFieldComponent.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

import SwiftUI

struct SwiftUIFieldComponent: View {
    let placeholder: String
    @State var value: String
    let buttonTitle: String
    let buttonColor: Color
    let action: () -> Void
    var textFieldText: (String) -> Void = { _ in }
    
    var body: some View {
        VStack(spacing: 30) {
            TextField(placeholder, text: $value)
                .padding()
                .background {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundStyle(.white)
                        RoundedRectangle(cornerRadius: 5)
                            .stroke()
                    }
                }
                .textFieldStyle(.automatic)
            Button(buttonTitle) {
                action()
            }
            .tint(buttonColor)
            .buttonStyle(.borderedProminent)
            .font(.title3)
        }
        .padding()
        .background(content: {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.pink.opacity(0.2))
        })
        .padding()
        .onChange(of: value) { _, newValue in
            textFieldText(newValue)
        }
    }
}

#Preview {
    SwiftUIFieldComponent(
        placeholder: "Enter text",
        value: "",
        buttonTitle: "Tap me",
        buttonColor: .red,
        action: {
            print("Button tapped")
        }
    )
}
