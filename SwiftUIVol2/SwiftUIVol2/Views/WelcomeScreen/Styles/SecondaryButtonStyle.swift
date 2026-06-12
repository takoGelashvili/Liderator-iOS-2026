//
//  SecondaryButtonStyle.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 12/06/2026.
//

import SwiftUI

extension ButtonStyle where Self == SecondaryButtonStyle {
    static var secondary: SecondaryButtonStyle {
        SecondaryButtonStyle()
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.orange.opacity(0.2))
            .overlay {
                configuration.label
                    .foregroundStyle(.orange)
            }
            .frame(height: 40)
    }
}
