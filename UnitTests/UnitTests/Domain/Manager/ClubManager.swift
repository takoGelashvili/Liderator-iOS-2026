//
//  ClubManager.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

protocol ClubManager {
    func addCustomer(customer: Customer) -> Bool
    func removeCustomer()
}

final class ClubManagerImpl: ClubManager {
    private static let maxNumCustomers: Int = 100
    private static let minAge: Int = 21
    
    static let shared = ClubManager()
    
    private init() {}

    private var numCustomers: Int = .zero
    
    func addCustomer(customer: Customer) -> Bool {
        if isEligableAge(age: customer.age) && !customer.isDrunk && customer.passedFaceControl {
            numCustomers += 1
            return true
        }
        
        return false
    }
    
    private func isEligableAge(age: Int) -> Bool {
        age >= Self.minAge
    }
    
    func removeCustomer() {
        if numCustomers > 0 {
            numCustomers -= 1
        }
    }
}
