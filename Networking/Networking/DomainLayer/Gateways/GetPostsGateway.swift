//
//  GetPostsGateway.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

typealias GetPostsCompletionHandler = (Result<[Post], Error>) -> Void

protocol GetPostsGateway {
    func fetchPosts(limit: Int, completion: @escaping GetPostsCompletionHandler)
}


// MOCK
struct GetPostGatewayMock: GetPostsGateway {
    var shouldShowError: Bool = false
    
    func fetchPosts(limit: Int, completion: @escaping GetPostsCompletionHandler) {
        if shouldShowError {
            completion(.failure(NoDataError()))
        } else {
            completion(.success([.init(userId: 0, id: 0, title: "MOCK_TITLE", body: nil)]))
        }
    }
}
