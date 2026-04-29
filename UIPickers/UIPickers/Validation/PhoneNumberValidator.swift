//
//  PhoneNumberValidator.swift
//  UIPickers
//
//  Demonstrates BOTH responsibilities of TextInputValidator:
//   - per-keystroke filter (digits only, max length)
//   - commit-time normalisation (strips spaces, prepends dial code)
//

import Foundation

struct PhoneNumberValidator: TextInputValidator {
    let maxDigits: Int
    let dialCode: String

    init(maxDigits: Int = 10, dialCode: String = "+995") {
        self.maxDigits = maxDigits
        self.dialCode = dialCode
    }

    func shouldAcceptReplacement(currentText: String,
                                 range: NSRange,
                                 replacement: String) -> Bool {
        // Allow deletion unconditionally.
        if replacement.isEmpty { return true }

        // Digits only.
        guard replacement.allSatisfy(\.isNumber) else { return false }

        // Cap length. range.length is the number of chars being replaced.
        let projectedLength = currentText.count + replacement.count - range.length
        return projectedLength <= maxDigits
    }

    func validate(_ text: String) -> ValidationResult {
        let digits = text.filter(\.isNumber)
        guard digits.count == maxDigits else {
            return .invalid(reason: "Phone must be \(maxDigits) digits")
        }
        return .valid(normalisedText: "\(dialCode) \(digits)")
    }
}
