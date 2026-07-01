//
//  ViewModel.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

import Foundation
import Observation

@Observable
@MainActor
final class ViewModel {
    struct State {
        var currentCustomer: Customer?
        var members: [Customer] = []
        var isLoading: Bool = true
        var errorMessage: String?
        var accessStatus: CustomerAccesStatus?
        
        enum CustomerAccesStatus {
            case enter
            case reject(rejectionReason: String)
        }
    }
    
    enum Intent {
        case selectCustomer(Customer)
        case deselectCustomer
        case registerAsMemberClicked
        case newCustomerRequiresAccess
        case currentCustomerLeft
        case goToDetailsButtonTapped
        case reload
    }
    
    var state: State = .init()
    
    private let fetchMembersUseCase: GetRegisteredMembersUseCase
    private let registerUseCase: RegisterAsClubMemberUseCase
    private let clubManager: ClubManager
    private let router: Router
    
    init(
        fetchMembersUseCase: GetRegisteredMembersUseCase,
        registerUseCase: RegisterAsClubMemberUseCase,
        clubManager: ClubManager,
        router: Router
    ) {
        self.fetchMembersUseCase = fetchMembersUseCase
        self.registerUseCase = registerUseCase
        self.clubManager = clubManager
        self.router = router
    }
    
    func onLoad() async {
        await fetchMembers()
    }
    
    func hanleIntent(_ intent: Intent) async {
        switch intent {
        case .selectCustomer(let customer): selectCustomer(customer)
        case .deselectCustomer: deselectCustomer()
        case .registerAsMemberClicked: await registerAsMember()
        case .newCustomerRequiresAccess: newCustomerRequiresAccess()
        case .currentCustomerLeft: currentCustomerLeft()
        case .goToDetailsButtonTapped:
        case .reload: await fetchMembers()
        }
    }
}

private extension ViewModel {
    func fetchMembers() async {
        do {
            state.members = try await fetchMembersUseCase.fetchMembers()
        } catch {
            state.errorMessage = error.localizedDescription
        }
        
        state.isLoading = false
    }
    
    func selectCustomer(_ customer: Customer) {
        state.currentCustomer = customer
    }
    
    func deselectCustomer() {
        state.currentCustomer = nil
    }
    
    func registerAsMember() async {
        guard let currentCustomer = state.currentCustomer else {
            state.errorMessage = "Please select a customer"
            return
        }
        
        guard !state.members.contains(currentCustomer) else {
            state.errorMessage = "Please select a customer"
            return
        }
        
        do {
            try await registerUseCase.register(customer: currentCustomer)
        } catch {
            state.errorMessage = error.localizedDescription
        }
    }
    
    func newCustomerRequiresAccess() {
        guard let currentCustomer = state.currentCustomer else {
            state.errorMessage = "Please select a customer"
            return
        }
        
        let canEnter = clubManager.addCustomer(customer: currentCustomer)
        state.accessStatus = canEnter ? .enter : .reject(rejectionReason: "")
        deselectCustomer()
    }
    
    func currentCustomerLeft() {        
        clubManager.removeCustomer()
        deselectCustomer()
    }
    
    func goToDetailsButtonTapped() {
        guard let currentCustomer = state.currentCustomer else {
            state.errorMessage = "Please select a customer"
            return
        }
        
        router.moveToDetails(customer: state.currentCustomer)
    }
}
