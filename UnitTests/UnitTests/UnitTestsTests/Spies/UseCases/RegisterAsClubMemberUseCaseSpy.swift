//
//  RegisterAsClubMemberUseCaseSpy.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

struct RegisterAsClubMemberUseCaseSpy: RegisterAsClubMemberUseCase {
    var shouldThrowError: Bool = false
    var didCallRegister: Bool = false
    
    func register(customer: Customer) async throws {
        didCallRegister = true
        
        if shouldThrowError {
            throw TestError()
        }
    }
}
