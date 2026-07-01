//
//  GetRegisteredMembersUseCase.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

protocol GetRegisteredMembersUseCase {
    func fetchMembers() async throws -> [Customer]
}

struct GetRegisteredMembersUseCaseImpl: GetRegisteredMembersUseCase {
    let gateway: GetRegisteredMembersGateway
    
    init(gateway: GetRegisteredMembersGateway) {
        self.gateway = gateway
    }
    
    func fetchMembers() async throws -> [Customer] {
        try await gateway.fetchMembers()
    }
}
