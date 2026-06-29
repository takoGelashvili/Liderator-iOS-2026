//
//  ViewController.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

import UIKit
import SwiftUI

final class ViewController: UIViewController {
    var presenter: Presenter!
    private var hosting: UIHostingController<SwiftUIFieldComponent>!
    
    private let vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private let addButton: UIButton = {
        var conf = UIButton.Configuration.borderedProminent()
        conf.cornerStyle = .capsule
        conf.title = "Add"
        let button = UIButton(configuration: conf)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let removeButton: UIButton = {
        var conf = UIButton.Configuration.borderedProminent()
        conf.cornerStyle = .capsule
        conf.title = "Remove"
        let button = UIButton(configuration: conf)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let changeColorButton: UIButton = {
        var conf = UIButton.Configuration.borderedProminent()
        conf.cornerStyle = .capsule
        conf.title = "Change color"
        let button = UIButton(configuration: conf)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let pushButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Push", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(vStack)
        add()
        vStack.addArrangedSubview(addButton)
        vStack.addArrangedSubview(removeButton)
        vStack.addArrangedSubview(changeColorButton)
        vStack.addArrangedSubview(pushButton)
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.heightAnchor.constraint(equalToConstant: 500)
        ])
        
        setUpButtonActions()
    }
    
    private func setUpButtonActions() {
        addButton.addAction(UIAction(handler: { [weak self] _ in
            self?.add()
        }), for: .touchUpInside)
        
        removeButton.addAction(UIAction(handler: { [weak self] _ in
            self?.remove()
        }), for: .touchUpInside)
        
        changeColorButton.addAction(UIAction(handler: { [weak self] _ in
            self?.changeColor()
        }), for: .touchUpInside)
        
        pushButton.addAction(UIAction(handler: { [weak self] _ in
            self?.presenter.didTapPushButton()
        }), for: .touchUpInside)
    }
    
    private func add() {
        hosting = UIHostingController(
            rootView:
                SwiftUIFieldComponent(
                    placeholder: "Placeholder",
                    value: "",
                    buttonTitle: "Tappp",
                    buttonColor: .red,
                    action: {
                        print("")
                    },
                    textFieldText: { textFieldText in
                        print(textFieldText)
                    }
                )
        )
        
        let component = hosting.view!
        addChild(hosting)
        vStack.addArrangedSubview(component)
        component.translatesAutoresizingMaskIntoConstraints = false
        
        hosting.didMove(toParent: self)
    }
    
    private func remove() {
        hosting.willMove(toParent: nil)
        hosting.view.removeFromSuperview()
        hosting.removeFromParent()
    }
    
    private func changeColor() {
        hosting.rootView = SwiftUIFieldComponent(
            placeholder: "Placeholder",
            value: "",
            buttonTitle: "Tappp",
            buttonColor: .purple,
            action: {
                print("")
            },
            textFieldText: { textFieldText in
                print(textFieldText)
            }
        )
    }
}

