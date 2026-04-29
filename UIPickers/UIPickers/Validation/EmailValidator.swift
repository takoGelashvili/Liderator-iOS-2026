//
//  EmailValidator.swift
//  UIPickers
//
//  Concrete strategy. No keystroke filtering (we want users to be able to
//  type any character on the way to a valid email), only commit-time check.
//

import Foundation

struct EmailValidator: TextInputValidator {
    // RFC-5322 is overkill; the practical regex is fine for UI-side checks.
    private static let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#

    func validate(_ text: String) -> ValidationResult {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            return .invalid(reason: "Email is required")
        }
        let range = NSRange(trimmed.startIndex..., in: trimmed)
        let regex = try? NSRegularExpression(pattern: Self.pattern,
                                             options: [.caseInsensitive])
        guard regex?.firstMatch(in: trimmed, range: range) != nil else {
            return .invalid(reason: "Enter a valid email address")
        }
        return .valid(normalisedText: trimmed.lowercased())
    }
}
