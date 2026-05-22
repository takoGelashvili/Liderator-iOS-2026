//
//  PostsRouter.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

import UIKit

protocol PostsRouter {
    // TODO
}

struct PostsRouterImpl: PostsRouter {
    weak var vc: UIViewController?
    
    init(_ vc: UIViewController) {
        self.vc = vc
    }
}
