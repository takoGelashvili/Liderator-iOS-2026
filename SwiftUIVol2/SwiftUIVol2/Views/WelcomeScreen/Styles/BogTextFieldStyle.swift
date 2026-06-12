//
//  BogTextFieldStyle.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

extension TextFieldStyle where Self == BogTextfieldStyle {

    static var bog: BogTextfieldStyle { BogTextfieldStyle() }
    static var bogError: BogTextfieldStyle { BogTextfieldStyle(isError: true) }
}

struct BogTextfieldStyle: TextFieldStyle {
    var isError: Bool = false

    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke()
                    .foregroundStyle(isError ? .red : .orange)
            }
    }
}
