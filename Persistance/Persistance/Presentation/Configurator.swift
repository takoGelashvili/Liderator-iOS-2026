//
//  Configurator.swift
//  Persistance
//
//  Created by Tamar Gelashvili on 25/05/2026.
//

import UIKit

protocol Configurator {
    func configure(_ vc: ViewController, gateway: PersisitanceGateway)
}

struct ConfiguratorImpl: Configurator {
    func configure(_ vc: ViewController, gateway: PersisitanceGateway) {
        let presenter = PresenterImpl(
            view: vc,
            useCase: PersistanceUseCaseImpl(gateway: gateway)
        )
        
        vc.presenter = presenter
    }
}
