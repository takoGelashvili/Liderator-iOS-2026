//
//  FormCoordinator.swift
//  UIPickers
//
//  The "next step" lesson for interns.
//
//  When a single VC has to implement multiple delegate protocols
//  (UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource…),
//  the file becomes unreadable. The coordinator pattern extracts those
//  into a dedicated object whose ONLY job is to implement delegate
//  callbacks and drive form state.
//
//  Benefits:
//   - VC stays focused on layout + lifecycle.
//   - Coordinator is trivially unit-testable (no UIViewController to host).
//   - Adding another text field doesn't enlarge the VC.
//

import UIKit

/// Aggregated state the coordinator publishes back to the screen.
struct FormState {
    var email: ValidationResult?
    var phone: ValidationResult?
    var country: Country?

    var isComplete: Bool {
        (email?.isValid ?? false) && (phone?.isValid ?? false) && country != nil
    }
}

protocol FormCoordinatorOutput: AnyObject {
    func formCoordinator(_ coordinator: FormCoordinator,
                         didUpdate state: FormState)
}

/// Hosts and observes the form's components. The view controller owns this
/// strongly; the coordinator holds the VC weakly through `output`.
final class FormCoordinator: NSObject {

    // MARK: Output

    weak var output: FormCoordinatorOutput?

    // MARK: Inputs (assigned by the VC)

    let emailField: ValidatedTextField
    let phoneField: ValidatedTextField
    let countryPicker: UIPickerView
    let countries: [Country]

    // MARK: State

    private(set) var state = FormState()

    // MARK: Init

    init(emailField: ValidatedTextField,
         phoneField: ValidatedTextField,
         countryPicker: UIPickerView,
         countries: [Country] = Country.demoData) {
        self.emailField = emailField
        self.phoneField = phoneField
        self.countryPicker = countryPicker
        self.countries = countries
        super.init()
        precondition(!countries.isEmpty, "Need at least one country")

        emailField.delegate = self
        phoneField.delegate = self
        countryPicker.dataSource = self
        countryPicker.delegate = self

        // Seed state.
        state.country = countries[0]
    }
}

// MARK: - UITextFieldDelegate

extension FormCoordinator: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let field = textField as? ValidatedTextField else { return true }
        return field.validator.shouldAcceptReplacement(
            currentText: field.text ?? "",
            range: range,
            replacement: string)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        commit(textField)
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField,
                                reason: UITextField.DidEndEditingReason) {
        guard reason == .committed else { return }
        commit(textField)
    }

    private func commit(_ textField: UITextField) {
        guard let field = textField as? ValidatedTextField else { return }
        let result = field.commit()
        if field === emailField { state.email = result }
        if field === phoneField { state.phone = result }
        output?.formCoordinator(self, didUpdate: state)
    }
}

// MARK: - UIPickerViewDataSource

extension FormCoordinator: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        countries.count
    }
}

// MARK: - UIPickerViewDelegate

extension FormCoordinator: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        let c = countries[row]
        return "\(c.flag)  \(c.name)  \(c.dialCode)"
    }

    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        let country = countries[row]
        state.country = country
        // Phone validator is country-aware — swap it on country change.
        phoneField.validator = CompositeValidator(
            LengthValidator(min: 9, max: 12, fieldName: "Phone"),
            PhoneNumberValidator(maxDigits: 12, dialCode: country.dialCode)
        )
        output?.formCoordinator(self, didUpdate: state)
    }
}
