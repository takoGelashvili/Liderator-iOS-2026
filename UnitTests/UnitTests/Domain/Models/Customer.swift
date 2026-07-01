//
//  Customer.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

import Foundation

struct Customer {
    let id: UUID
    let name: String
    let age: Int
    let gender: Gender
    let numShotsDrank: Int
    
    var isDrunk: Bool {
        switch gender {
        case .female:
            return numShotsDrank > 10
        case .male:
            return numShotsDrank > 5
        }
    }
    
    var passedFaceControl: Bool {
        switch gender {
        case .female: return true
        case .male: return Bool.random()
        }
    }
}

extension [Customer] {
    func contains(_ customer: Customer) -> Bool {
        contains(where: { $0.id == customer.id })
    }
}

enum Gender {
    case female
    case male
}
