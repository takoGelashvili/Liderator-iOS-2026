//
//  Router.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

protocol Router {
    func moveToDetails(customer: Customer)
}

struct RouterImpl {
    func moveToDetails(customer: Customer) {
        // would navigate to details page here
    }
}
