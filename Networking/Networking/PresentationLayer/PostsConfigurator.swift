//
//  PostsConfigurator.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//


protocol PostsConfigurator {
    func configure(_ vc: PostViewController)
}

struct PostsConfiguratorImpl: PostsConfigurator {
    func configure(_ vc: PostViewController) {
        let router = PostsRouterImpl(vc)
        let presenter = PostsPresenterImpl(
            view: vc,
            useCase: GetPostsUseCaseImpl(gateway: ApiGetPostsGateway()),
            router: router
        )
        
        vc.presenter = presenter
    }
}
