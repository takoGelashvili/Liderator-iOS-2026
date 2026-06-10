//
//  RGB.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct RGB {
    @Clamping(in: 0...0.5) var red: Double = .zero
    @Clamping(in: 0...1) var green: Double = .zero
    @Clamping(in: 0...0.3) var blue: Double = .zero
    
    var color: Color {
        Color(red: red, green: green, blue: blue)
    }
    
    static var random: RGB {
        .init(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
}
