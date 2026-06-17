//
//  ObservableApp.swift
//  Observable
//
//  Created by Tamar Gelashvili on 17/06/2026.
//

import SwiftUI

@main
struct ObservableApp: App {
    var body: some Scene {
        WindowGroup {
            CartView(vm: CartViewModelImpl(useCase: ItemsUseCaseImpl()))
        }
    }
}
