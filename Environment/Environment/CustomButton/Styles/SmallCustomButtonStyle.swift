//
//  SmallCustomButtonStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct SmallCustomButtonStyle: CustomButtonStyle {
    func makeBody(with configuration: CustomButtonConfiguration) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .foregroundStyle(.orange.opacity(0.3))
            .overlay {
                Image(systemName: configuration.iconName)
                    .foregroundStyle(.orange)
            }
            .frame(width: 60, height: 60)
    }
}

#Preview {
    CustomButtonView(
        buttonConfiguration: .init(
            iconName: "person",
            buttonAction: {
                print("TAP")
            }
        )
    )
    .customButtonStyle(.small)
}
