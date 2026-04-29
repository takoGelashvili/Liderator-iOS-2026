//
//  ValidationResult.swift
//  UIPickers
//
//  A typed result from a validator. `valid` carries the (possibly normalised)
//  text; `invalid` carries a user-facing reason. Using an enum (not Bool)
//  forces callers to handle the failure case — much harder to ignore an error.
//

import Foundation

enum ValidationResult: Equatable {
    case valid(normalisedText: String)
    case invalid(reason: String)

    var isValid: Bool {
        if case .valid = self { return true }
        return false
    }

    var errorMessage: String? {
        if case .invalid(let reason) = self { return reason }
        return nil
    }
}
