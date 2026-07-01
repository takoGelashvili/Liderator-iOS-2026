//
//  RegisterAsClubMemberUseCase.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

protocol RegisterAsClubMemberUseCase {
    func register(customer: Customer) async throws
}

struct RegisterAsClubMemberUseCaseImpl: RegisterAsClubMemberUseCase {
    let gateway: RegisterAsClubMemberGateway
    
    init(gateway: RegisterAsClubMemberGateway) {
        self.gateway = gateway
    }
    
    func register(customer: Customer) async throws {
        try await gateway.register(customer: customer)
    }
}
