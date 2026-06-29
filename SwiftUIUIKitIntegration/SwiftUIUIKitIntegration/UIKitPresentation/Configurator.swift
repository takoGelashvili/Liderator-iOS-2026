//
//  Configurator.swift
//  SwiftUIUIKitIntegration
//
//  Created by Tamar Gelashvili on 29/06/2026.
//

struct Configurator {
    func configure(_ vc: ViewController) {
        let router = RouterImpl(viewController: vc)
        let presenter = PresenterImpl(router: router)
        vc.presenter = presenter
    }
}
