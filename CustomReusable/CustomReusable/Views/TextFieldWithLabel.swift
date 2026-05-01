//
//  TextFieldWithLabel.swift
//  CustomReusable
//
//  Created by Tamar Gelashvili on 01/05/2026.
//

import UIKit

struct TextFieldWithLabelViewModel {
    let placeholder: String
    let keyboardType: UIKeyboardType
}

struct TextFieldWithLabelDelegateResponse {
    let allowWrite: Bool
    let errorText: String?
}

protocol TextFieldWithLabelDelegate: AnyObject {
    func showErrrorText(textFieldString: String) -> TextFieldWithLabelDelegateResponse
}

final class TextFieldWithLabelView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private let vStack: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.alignment = .leading
        v.distribution = .fill
        v.spacing = 20
        return v
    }()
    
    private let textField: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        
        t.layer.cornerRadius = 5
        t.layer.borderColor = UIColor.black.cgColor
        t.layer.borderWidth = 2
        
        t.textAlignment = .center
        
        return t
    }()
    
    private let label: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .red
        l.isHidden = true
        
        return l
    }()
    
    weak var delegate: TextFieldWithLabelDelegate?
}

extension TextFieldWithLabelView {
    private func commonInit() {
        textField.delegate = self

        setUpSubviews()
        setUpConstraints()
    }
    
    private func setUpSubviews() {
        addSubview(vStack)
        vStack.addArrangedSubview(textField)
        vStack.addArrangedSubview(label)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: topAnchor),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 60),
            textField.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension TextFieldWithLabelView {
    func configire(with viewModel: TextFieldWithLabelViewModel) {
        textField.placeholder = viewModel.placeholder
        textField.keyboardType = viewModel.keyboardType
    }
}

extension TextFieldWithLabelView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let delegate else { return false }
        
        let response = delegate.showErrrorText(textFieldString: "\(textField.text ?? "")\(string)")
        
        if let errorText = response.errorText {
            label.isHidden = false
            label.text = errorText
        } else {
            label.isHidden = true
        }
        
        return response.allowWrite
    }
}
