//
//  CustomButtonView.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct CustomButtonView: View {
    @Environment(\.customButtonStyle) var customButtonStyle
    
    let buttonConfiguration: CustomButtonConfiguration
    
    var body: some View {
        customButtonStyle.makeBody(with: buttonConfiguration)
    }
}
