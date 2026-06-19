//
//  AnyCustomButtonStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

extension View {
    func customButtonStyle(_ style: AnyCustomButtonStyle) -> some View {
        environment(\.customButtonStyle, style)
    }
}

struct AnyCustomButtonStyle: CustomButtonStyle {
    //private let style: any CustomButtonStyle
    private let _makeBody: (CustomButtonConfiguration) -> AnyView
    
    init<S: CustomButtonStyle>(_ style: S) {
        //self.style = style
        self._makeBody = { configuration in
            AnyView(style.makeBody(with: configuration))
        }
    }
    
    func makeBody(with configuration: CustomButtonConfiguration) -> AnyView {
        _makeBody(configuration)
    }
}

extension AnyCustomButtonStyle {
    static let large = AnyCustomButtonStyle(LargeCustomButtonStyle())
    static let small = AnyCustomButtonStyle(SmallCustomButtonStyle())
}
