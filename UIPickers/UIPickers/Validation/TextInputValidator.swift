//
//  TextInputValidator.swift
//  UIPickers
//
//  Strategy pattern. A field doesn't know HOW it's validated — it only
//  knows it has *a* validator. Swap implementations freely.
//
//  Two responsibilities are intentionally split:
//
//    `shouldAcceptReplacement(...)` — synchronous, called per-keystroke from
//        UITextFieldDelegate.shouldChangeCharactersIn. Filter input here.
//
//    `validate(...)` — called on commit (e.g. on blur or submit) to produce
//        a structured pass/fail. May be more expensive (regex, network…).
//

import Foundation

protocol TextInputValidator {
    /// Per-keystroke filter. Return `false` to reject the change entirely.
    /// Default implementation accepts everything — override only when filtering.
    func shouldAcceptReplacement(currentText: String,
                                 range: NSRange,
                                 replacement: String) -> Bool

    /// Final check called on commit. Must always return a result.
    func validate(_ text: String) -> ValidationResult
}

extension TextInputValidator {
    func shouldAcceptReplacement(currentText: String,
                                 range: NSRange,
                                 replacement: String) -> Bool { true }
}
