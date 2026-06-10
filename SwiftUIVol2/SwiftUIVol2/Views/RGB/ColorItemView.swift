//
//  ColorItemView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct ColorItemView: View {
    @Binding var value: Double
    var colorFirstLetter: String
    var color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundStyle(color.opacity(0.4))
            .overlay {
                Text("\(colorFirstLetter): \(Int(value * 256))")
                    .foregroundStyle(color)
            }
    }
}
