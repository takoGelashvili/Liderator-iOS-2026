//
//  RGBView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct RGBView: View {
    @State var rgb: RGB
    
    var body: some View {
        VStack(spacing: 40) {
            CircleRandomizerView(rgb: $rgb)
                .padding(.horizontal, 30)
            RGBNumsView(rgb: $rgb)
            SliderView(value: $rgb.red, color: .red)
            SliderView(value: $rgb.green, color: .green)
            SliderView(value: $rgb.blue, color: .blue)
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    RGBView(rgb: .random)
}
