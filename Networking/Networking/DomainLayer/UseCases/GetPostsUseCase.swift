//
//  GetPostsUseCase.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

protocol GetPostsUseCase {
    func fetchPosts(limit: Int) async throws -> [Post]
}

struct GetPostsUseCaseImpl: GetPostsUseCase {
    private var gateway: GetPostsGateway
    
    init(gateway: GetPostsGateway) {
        self.gateway = gateway
    }
    
    func fetchPosts(limit: Int) async throws -> [Post] {
        try await withCheckedThrowingContinuation { continuation in
            gateway.fetchPosts(limit: limit) { result in
                switch result {
                case .success(let posts):
                    continuation.resume(returning: posts)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
