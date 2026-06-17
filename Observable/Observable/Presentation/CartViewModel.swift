//
//  CartViewModel.swift
//  Observable
//
//  Created by Tamar Gelashvili on 17/06/2026.
//

import Observation
import Foundation

@MainActor
struct CartViewModelState {
    var items: [CartItem]
    var itemsInCart: [CartItem]
}

enum CartIntent {
    case didTapItem(item: CartItem)
}

protocol CartViewModel {
    func onLoad() async
    func handleIntent(_ intent: CartIntent)
    var state: CartViewModelState { get }
}

@Observable
final class CartViewModelImpl: CartViewModel {
    let useCase: ItemsUseCase
    var state: CartViewModelState
    
    @ObservationIgnored var id: Int
    
    init(useCase: ItemsUseCase, id: Int = 5) {
        self.useCase = useCase
        self.id = id
        state = .init(items: [], itemsInCart: [])
    }
    
    func onLoad() async {
        print(Thread.isMainThread)
        self.state.items = await self.useCase.getItems()
        
        self.id = 7
    }
    
    func handleIntent(_ intent: CartIntent) {
        switch intent {
        case .didTapItem(let item):
            addItemToCart(item: item)
        }
    }
    
    private func addItemToCart(item: CartItem) {
        state.itemsInCart.append(item)
    }
}
