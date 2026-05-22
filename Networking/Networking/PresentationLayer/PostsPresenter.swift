//
//  Presenter.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

import Foundation

protocol PostsPresenter: AnyObject {
    func viewDidLoad() async
    var posts: [Post] { get }
}

final class PostsPresenterImpl: PostsPresenter {
    weak let view: PostView?
    let useCase: GetPostsUseCase
    let router: PostsRouter
    
    var posts: [Post] = []
    
    init(
        view: PostView,
        useCase: GetPostsUseCase,
        router: PostsRouter
    ) {
        self.view = view
        self.useCase = useCase
        self.router = router
    }
    
    func viewDidLoad() async {
        do {
            self.posts = try await useCase.fetchPosts(limit: 10)
            view?.showPosts()
        } catch {
            print("ERRO", error.localizedDescription)
        }
    }
}
