//
//  ValidatedTextField.swift
//  UIPickers
//
//  A UITextField subclass that holds a `TextInputValidator` strategy.
//  No custom delegate protocol — consumers set `.delegate` and implement
//  `UITextFieldDelegate` directly, calling into the field's validator
//  helpers as needed.
//
//  Public surface:
//    - `validator`     : strategy, swap at runtime
//    - `commit()`      : run validator, store result, paint border
//    - `lastResult`    : last commit's result (nil before first commit)
//

import UIKit

final class ValidatedTextField: UITextField {

    // MARK: Public API

    var validator: TextInputValidator

    /// Last result produced by `commit()`. Convenient for form-level
    /// "is everything valid?" checks.
    private(set) var lastResult: ValidationResult?

    // MARK: Init

    init(validator: TextInputValidator, placeholder: String) {
        self.validator = validator
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    // MARK: Commit (final validation)

    /// Run the commit-time validator and update visual state.
    /// Call this from the consumer's `textFieldShouldReturn` /
    /// `textFieldDidEndEditing`, or imperatively on form submission.
    @discardableResult
    func commit() -> ValidationResult {
        let result = validator.validate(text ?? "")
        lastResult = result
        applyVisualState(for: result)
        return result
    }

    // MARK: Visual feedback (no animation)

    private func applyVisualState(for result: ValidationResult) {
        layer.borderWidth = 1
        switch result {
        case .valid:   layer.borderColor = UIColor.systemGreen.cgColor
        case .invalid: layer.borderColor = UIColor.systemRed.cgColor
        }
    }
}
