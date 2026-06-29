//
//  SwiftUIPage.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

import SwiftUI

struct SwiftUIPage: View {
    @State private var color: ButtonColor = .red
    @State private var isHidden: Bool = false
    @State private var text: String = ""
    
    var body: some View {
        if !isHidden {
            SwiftUIFieldRepresentable(
                placeholder: "Enter your name",
                buttonTitle: "Taaap",
                text: $text,
                buttonColor: $color) {
                    print(text)
                }
                .frame(height: 250)
        } else {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(height: 250)
        }
        
        HStack {
            Button("red") {
                color = .red
            }
            
            Button("purple") {
                color = .purple
            }
            
            Button("pink") {
                color = .pink
            }
        }
        
        Toggle(isOn: $isHidden) {
            Text("Hide view")
        }
        .tint(.pink)
        .padding(.horizontal, 20)
    }
}


#Preview {
    SwiftUIPage()
}
