//
//  RGBNumsView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct RGBNumsView: View {
    @Binding var rgb: RGB
    
    var body: some View {
        HStack(spacing: 20) {
            ColorItemView(value: $rgb.red,
                          colorFirstLetter: "R",
                          color: .red)
            ColorItemView(value: $rgb.green,
                          colorFirstLetter: "G",
                          color: .green)
            ColorItemView(value: $rgb.blue,
                          colorFirstLetter: "B",
                          color: .blue)
        }
        .frame(height: 70)
        .padding(20)
        .overlay(content: {
            RoundedRectangle(cornerRadius: 20)
                .stroke()
                .foregroundStyle(.gray)
        })
    }
}
