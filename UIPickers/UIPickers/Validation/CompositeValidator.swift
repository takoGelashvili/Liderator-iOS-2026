//
//  CompositeValidator.swift
//  UIPickers
//
//  Composite pattern: a validator built from other validators.
//  Both filter and validation calls are forwarded — the composite passes
//  only when ALL children pass, and rejects on the FIRST failure.
//
//  Teaches interns:
//   - Strategy + Composite combine cleanly.
//   - Order matters: children run in declaration order, so put cheap
//     checks (length) before expensive ones (regex, network).
//

import Foundation

struct CompositeValidator: TextInputValidator {
    let children: [TextInputValidator]

    init(_ children: TextInputValidator...) {
        self.children = children
    }

    func shouldAcceptReplacement(currentText: String,
                                 range: NSRange,
                                 replacement: String) -> Bool {
        children.allSatisfy {
            $0.shouldAcceptReplacement(currentText: currentText,
                                       range: range,
                                       replacement: replacement)
        }
    }

    func validate(_ text: String) -> ValidationResult {
        var lastValid: ValidationResult = .valid(normalisedText: text)
        for child in children {
            let result = child.validate(text)
            if !result.isValid { return result }
            lastValid = result
        }
        return lastValid
    }
}
