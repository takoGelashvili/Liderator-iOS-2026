//
//  RouterSpy.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

final class RouterSpy: Router {
    var detailsCustomer: Customer?
    
    func moveToDetails(customer: Customer) {
        detailsCustomer = customer
    }
}
