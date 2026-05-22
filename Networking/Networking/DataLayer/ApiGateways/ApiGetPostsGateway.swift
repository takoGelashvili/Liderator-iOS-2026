//
//  ApiGetPostsGateway.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

import Foundation

struct ApiGetPostsGateway: GetPostsGateway {
    func fetchPosts(limit: Int, completion: @escaping GetPostsCompletionHandler) {
        var urlComponents = URLComponents(string: "https://jsonplaceholder.typicode.com/posts")
        urlComponents?.queryItems = [.init(name: "_limit", value: "\(limit)")]
        
        Fetcher<[ApiPost]>.request(
            with: urlComponents?.url
        ) { result in
            switch result {
            case .success(let apiPosts):
                completion(.success(apiPosts.compactMap { $0.toModel } ))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
