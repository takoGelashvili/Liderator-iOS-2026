//
//  Presenter.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

protocol Presenter {
    func didTapTextFieldButton()
    func didTapPushButton()
}

final class PresenterImpl: Presenter {
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func didTapTextFieldButton() {
        
    }
    
    func didTapPushButton() {
        router.navigateToSwiftUI()
    }
}
