//
//  RegisterAsClubMemberGateway.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

protocol RegisterAsClubMemberGateway {
    func register(customer: Customer) async throws
}
