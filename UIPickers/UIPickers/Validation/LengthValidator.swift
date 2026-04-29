//
//  LengthValidator.swift
//  UIPickers
//
//  Generic min/max-length validator. Useful on its own, or as a building
//  block inside a CompositeValidator.
//

import Foundation

struct LengthValidator: TextInputValidator {
    let min: Int
    let max: Int
    let fieldName: String

    func shouldAcceptReplacement(currentText: String,
                                 range: NSRange,
                                 replacement: String) -> Bool {
        if replacement.isEmpty { return true }
        let projected = currentText.count + replacement.count - range.length
        return projected <= max
    }

    func validate(_ text: String) -> ValidationResult {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.count < min {
            return .invalid(reason: "\(fieldName) must be at least \(min) characters")
        }
        if trimmed.count > max {
            return .invalid(reason: "\(fieldName) must be at most \(max) characters")
        }
        return .valid(normalisedText: trimmed)
    }
}
