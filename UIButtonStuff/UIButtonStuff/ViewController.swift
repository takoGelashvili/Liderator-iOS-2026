//
//  ViewController.swift
//  UIButtonStuff
//
//  Created by Tamar Gelashvili on 27/04/2026.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var pinkButton: UIView = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Pink Button"
        configuration.baseBackgroundColor = .systemPink
        configuration.baseForegroundColor = .white
        
        configuration.image = UIImage(systemName: "star.fill")
        configuration.imagePlacement = .trailing
        
        configuration.background.strokeColor = .black
        configuration.background.strokeWidth = 2
        
        configuration.cornerStyle = .capsule
        
        let b = UIButton(configuration: configuration, primaryAction: UIAction { _ in
            print("BUTTON PRESSED")
        }) // modern api
        
        b.addTarget(self, action: #selector(pinkButtonTappedAction), for: .touchUpInside) // old
        b.translatesAutoresizingMaskIntoConstraints = false
        
        return b
    }()
    
    @objc
    private func pinkButtonTappedAction() {
        print("OLD API BUTTON TAPPED")
    }
    
    lazy var helloKitty: UIImageView = {
        let kitty = UIImageView(image: UIImage(named: "hello_kitty"))
        kitty.translatesAutoresizingMaskIntoConstraints = false
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(helloKittyTappedAction))
        kitty.addGestureRecognizer(gesture)
        kitty.isUserInteractionEnabled = true
        
        return kitty
    }()
    
    @objc
    private func helloKittyTappedAction() {
        print("HELLO KITTY TAPPED")
    }
    
    lazy var stack: UIStackView = {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .equalSpacing
        vStack.spacing = 20
        vStack.alignment = .center
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    lazy var label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
//        l.text = "Hello Kitty"
//        l.font = .systemFont(ofSize: 30, weight: .bold)
//        l.textColor = UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 0.7)
        
        l.attributedText = NSAttributedString(string: "Hello Kitty", attributes: [
            .foregroundColor: UIColor(red: 0.5, green: 0, blue: 0.5, alpha: 0.7),
        ])
        
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubView()
        setUpContraints()
    }
}

extension ViewController {
    private func setUpSubView() {
        view.addSubview(stack)
        stack.addArrangedSubview(pinkButton)
        stack.addArrangedSubview(helloKitty)
        stack.addArrangedSubview(label)
    }
    
    private func setUpContraints() {
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            pinkButton.heightAnchor.constraint(equalToConstant: 50),
            pinkButton.widthAnchor.constraint(equalToConstant: 260),
            
            helloKitty.heightAnchor.constraint(equalToConstant: 200),
            helloKitty.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}


