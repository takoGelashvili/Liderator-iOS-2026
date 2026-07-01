//
//  ViewModelTests.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

import Testing

//enum Intent {
//    case selectCustomer(Customer)
//    case deselectCustomer
//    case registerAsMemberClicked
//    case newCustomerRequiresAccess
//    case currentCustomerLeft
//    case goToDetailsButtonTapped
//    case reload

@Suite("Club view model tests")
struct ViewModelTests {
    private let router: R
    
    private func setUpSut() -> (viewModel: ViewModel) {
        let customerService = CustomerService()
        let viewModel = ClubViewModel(customerService: customerService)
        return (viewModel, customerService)
    }
    
    @Test func `View did appear. Should fetch members`() async throws {
        
    }
}
