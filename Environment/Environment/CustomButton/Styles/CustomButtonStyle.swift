//
//  CustomButtonStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

protocol CustomButtonStyle {
    associatedtype Body: View
    func makeBody(with configuration: CustomButtonConfiguration) -> Body
}
