//
//  UIKitFieldComponent.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

import UIKit

final class UIKitFieldComponent: UIView {
    
    private let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.cornerRadius = 20
        v.backgroundColor = .systemPink.withAlphaComponent(0.2)
        return v
    }()
    
    private let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let button: UIButton = {
        var conf = UIButton.Configuration.borderedProminent()
        conf.cornerStyle = .capsule
        let button = UIButton(configuration: conf)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpSubviews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIKitFieldComponent {
    private func setUpSubviews() {
        addSubview(container)
        container.addSubview(vStack)
        vStack.addArrangedSubview(textField)
        vStack.addArrangedSubview(button)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            container.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            vStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            vStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            vStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            
            textField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            button.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}

// MARK: Public
extension UIKitFieldComponent {
    func configure(placeholder: String, buttonTitle: String, buttonColor: UIColor, action: @escaping () -> Void) {
        textField.placeholder = placeholder
        
        var conf = button.configuration
        conf?.title = buttonTitle
        conf?.baseBackgroundColor = buttonColor
        
        button.configuration = conf
        
        button.addAction(UIAction(handler: { _ in
            action()
        }), for: .touchUpInside)
    }
}
