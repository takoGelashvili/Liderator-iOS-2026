//
//  SwiftUIFieldRepresentable.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

import SwiftUI
import UIKit

enum ButtonColor {
    case red
    case purple
    case pink
    
    var color: UIColor {
        switch self {
        case .red: return .red
        case .purple: return .purple
        case .pink: return .systemPink
        }
    }
}

struct SwiftUIFieldRepresentable: UIViewRepresentable {
    let placeholder: String
    let buttonTitle: String
    @Binding var text: String
    @Binding var buttonColor: ButtonColor
    let action: () -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIKitFieldComponent {
        let uiKitView = UIKitFieldComponent()
        uiKitView.configure(
            placeholder: placeholder,
            buttonTitle: buttonTitle,
            buttonColor: buttonColor.color,
            action: action
        )
        
        uiKitView.textField.addTarget(
            context.coordinator,
            action: #selector(context.coordinator.textFieldDidChange(textField:)),
            for: .editingChanged
        )
                
        return uiKitView
    }
    
    func updateUIView(_ field: UIKitFieldComponent, context: Context) {
        field.configure(
            placeholder: placeholder,
            buttonTitle: buttonTitle,
            buttonColor: buttonColor.color,
            action: action
        )
    }
    
    final class Coordinator: NSObject {
        var parent: SwiftUIFieldRepresentable
        
        init(_ parent: SwiftUIFieldRepresentable) {
            self.parent = parent
        }
        
        @objc
        func textFieldDidChange(textField: UITextField) {
            if parent.text != textField.text {
                parent.text = textField.text ?? ""
            }
        }
    }
}
