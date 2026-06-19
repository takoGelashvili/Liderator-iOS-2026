//
//  CustomButtonConfiguration.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct CustomButtonConfiguration {
    let iconName: String
    let title: String?
    let buttonAction: () -> Void
    
    init(iconName: String, title: String? = nil, buttonAction: @escaping () -> Void) {
        self.iconName = iconName
        self.title = title
        self.buttonAction = buttonAction
    }
}
