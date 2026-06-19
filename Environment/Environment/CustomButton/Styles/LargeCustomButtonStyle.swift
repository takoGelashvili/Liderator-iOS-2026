//
//  LargeCustomButtonStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct LargeCustomButtonStyle: CustomButtonStyle {
    func makeBody(with configuration: CustomButtonConfiguration) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.orange.opacity(0.3))
            .overlay {
                HStack {
                    Image(systemName: configuration.iconName)
                    Text(configuration.title ?? "")
                }
                .foregroundStyle(.orange)
            }
            .frame(height: 60)
    }
}

#Preview {
    CustomButtonView(
        buttonConfiguration: .init(
            iconName: "person",
            title: "Profile",
            buttonAction: {
                print("TAP")
            }
        )
    )
}
