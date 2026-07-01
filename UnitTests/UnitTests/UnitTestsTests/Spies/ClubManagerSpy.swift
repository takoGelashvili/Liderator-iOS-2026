//
//  ClubManagerSpy.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

final class ClubManagerSpy: ClubManager {
    var isCustomerEligable: Bool = true
    var didRemoveCustomer: Bool = false
    
    func addCustomer(customer: Customer) -> Bool {
        isCustomerEligable
    }
    
    func removeCustomer() {
        didRemoveCustomer = true
    }
}
