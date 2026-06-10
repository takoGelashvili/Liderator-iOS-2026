//
//  SliderView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct SliderView: View {
    @Binding var value: Double
    let color: Color
    
    var body: some View {
        VStack {
            Slider(value: $value)
                .tint(color)
            HStack {
                Image(systemName: "moonphase.full.moon")
                Spacer()
                Image(systemName: "moonphase.first.quarter")
                Spacer()
                Image(systemName: "moonphase.new.moon")
            }.foregroundStyle(color)
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 30)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(.gray.opacity(0.4))
        }
    }
}
