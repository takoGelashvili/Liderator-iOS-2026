//
//  ViewController.swift
//  TextField
//
//  Created by Tamar Gelashvili on 29/04/2026.
//

import UIKit

final class ViewController: UIViewController {
    
    private let months: [String] = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    private let phoneTextField: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints = false
        
        t.placeholder = "Phone"
        t.borderStyle = .roundedRect
        
        t.layer.borderWidth = 1
        t.layer.borderColor = UIColor.black.cgColor
        
        t.keyboardType = .numberPad
        t.clearButtonMode = .always
        
        let image = UIImageView(image: UIImage(systemName: "eraser.fill"))
        t.leftView = image
        t.leftViewMode = .always
        
        return t
    }()
    
    private let picker: UIPickerView = {
        let p = UIPickerView()
        p.translatesAutoresizingMaskIntoConstraints = false
        return p
    }()
    
    private let vStack: UIStackView = {
        let v = UIStackView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.axis = .vertical
        v.alignment = .center
        
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        setUpSubiews()
        setUpConstraints()
        
        addDiagonalLine() // diagonal line for tik tak toe
    }
}

// MARK: Setting up subviews
extension ViewController {
    private func setUpDelegates() {
        phoneTextField.delegate = self
        picker.dataSource = self
        picker.delegate = self
    }
    
    private func setUpSubiews() {
        view.addSubview(vStack)
        vStack.addArrangedSubview(phoneTextField)
        vStack.addArrangedSubview(picker)
    }
    
    // ეს დავალებისთვის
    private func addDiagonalLine() {
        let line = CAShapeLayer()
        line.strokeColor = UIColor.red.cgColor
        line.lineWidth = 10
        
        let p = UIBezierPath()
        p.move(to: .init(x: 100, y: 100))
        p.addLine(to: .init(x: 200, y: 200))
        
        line.path = p.cgPath
        
        view.layer.addSublayer(line)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            phoneTextField.heightAnchor.constraint(equalToConstant: 50),
            phoneTextField.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        string.range(of: #"^[0-9]*$"#, options: .regularExpression) != nil
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("CLEAR")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        months.count
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        months[row]
    }

    func pickerView(_ pickerView: UIPickerView,
                    attributedTitleForRow row: Int,
                    forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(string: months[row], attributes: [.foregroundColor: UIColor.red])
    }

    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        if let view { return view }
        return UIImageView(image: UIImage(systemName: "heart.fill"))
    }
    
    // აქ აჩვენებს view-ს (ამ შემთხვევაში: გულებს), თუ view-ები არ გვაქვს - attributed title, თუ attributed title არ გვაქვს - title
}
