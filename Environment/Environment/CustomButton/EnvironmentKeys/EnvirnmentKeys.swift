//
//  EnvirnmentKeys.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct CustomButtonStyleKey: EnvironmentKey {
    static let defaultValue: AnyCustomButtonStyle = AnyCustomButtonStyle(LargeCustomButtonStyle())
}


extension EnvironmentValues {
    var customButtonStyle: AnyCustomButtonStyle {
        get {
            self[CustomButtonStyleKey.self]
        }
        set {
            self[CustomButtonStyleKey.self] = newValue
        }
    }
}
