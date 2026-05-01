//
//  ViewController.swift
//  CustomReusable
//
//  Created by Tamar Gelashvili on 01/05/2026.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func displayTextField()
}

final class ViewController: UIViewController {
    
    var presenter: Presenter!
    
    private let textFieldWithLabel: TextFieldWithLabelView = {
        let t = TextFieldWithLabelView()
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private let vStack: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.alignment = .leading
        v.distribution = .fill
        v.spacing = 20
        return v
    }()
    
    private let stepper: UIStepper = {
        let s = UIStepper()
        s.translatesAutoresizingMaskIntoConstraints = false
        
        s.minimumValue = .zero
        s.maximumValue = 10
        s.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
                
        return s
    }()
    
    private let stepperLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension ViewController {
    private func setUpSubviews() {
        view.addSubview(vStack)
        vStack.addArrangedSubview(textFieldWithLabel)
        vStack.addArrangedSubview(stepper)
        vStack.addArrangedSubview(stepperLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureSubViews() {
        let vm = TextFieldWithLabelViewModel(
            placeholder: "Enter your phone number",
            keyboardType: .phonePad
        )
        textFieldWithLabel.configire(with: vm)
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        let currentValue = Int(sender.value)
        stepperLabel.text = "\(currentValue)"
    }
}

extension ViewController: TextFieldWithLabelDelegate {
    func showErrrorText(textFieldString: String) -> TextFieldWithLabelDelegateResponse {
        let (isValid, errorText) = presenter.isValid(text: textFieldString)
        
        return .init(allowWrite: isValid, errorText: errorText)
    }
}

extension ViewController: ViewProtocol {
    func displayTextField() {
        view.backgroundColor = .white
        textFieldWithLabel.delegate = self
        
        stepperLabel.text = "\(Int(stepper.value))"
        
        setUpSubviews()
        setUpConstraints()
        configureSubViews()
    }
}
