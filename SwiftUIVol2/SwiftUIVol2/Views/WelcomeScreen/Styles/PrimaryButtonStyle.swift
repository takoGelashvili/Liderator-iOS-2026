//
//  PrimaryButtonStyle.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var primary: PrimaryButtonStyle {
        PrimaryButtonStyle()
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .foregroundStyle(.orange)
            .overlay {
                configuration.label
                    .foregroundStyle(.white)
            }
            .frame(height: 50)
    }
}
