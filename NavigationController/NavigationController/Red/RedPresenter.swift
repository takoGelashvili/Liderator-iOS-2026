//
//  RedPresenter.swift
//  NavigationController
//
//  Created by Tamar Gelashvili on 08/05/2026.
//

struct RedPresenter {
    private var router: RedRouter
    
    init(router: RedRouter) {
        self.router = router
    }
    
    func didTapButton() {
        router.navigateToBlue()
    }
}
