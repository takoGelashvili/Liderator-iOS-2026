//
//  CircleRandomizerView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct CircleRandomizerView: View {
    @Binding var rgb: RGB

    var body: some View {
        Circle()
            .stroke(
                rgb.color.opacity(0.4),
                style: .init(
                    lineWidth: 40,
                    dash: [20, 20]
                ))
            .fill(rgb.color)
            .foregroundStyle(rgb.color)
            .overlay {
                Button("Randomize") {
                    rgb = .random
                }
                .font(.largeTitle)
            }
        
    }
}
