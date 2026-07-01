//
//  GetRegisteredMembersUseCaseSpy.swift
//  UnitTests
//
//  Created by Tamar Gelashvili on 01/07/2026.
//

struct GetRegisteredMembersUseCaseSpy: GetRegisteredMembersUseCase {
    var shouldThrowError: Bool = false
    var resultToReturn: [Customer] = []
    
    func fetchMembers() async throws -> [Customer] {
        if shouldThrowError {
            throw TestError()
        }
        
        return resultToReturn
    }
}
