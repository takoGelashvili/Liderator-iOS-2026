//
//  GetRegisteredMembersGateway.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

protocol GetRegisteredMembersGateway {
    func fetchMembers() async throws -> [Customer]
}
