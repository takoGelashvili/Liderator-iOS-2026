//
//  ItemsUseCase.swift
//  Observable
//
//  Created by Tamar Gelashvili on 17/06/2026.
//

protocol ItemsUseCase {
    func getItems() async -> [CartItem]
}

struct ItemsUseCaseImpl: ItemsUseCase {
    func getItems() async -> [CartItem] {
        [
            .init(
                name: "Parfume",
                price: 600,
                description: "Vanila",
                imageName: "figure.roll.runningpace"
            ),
            .init(
                name: "Board",
                price: 20,
                description: "White",
                imageName: "clipboard.fill"
            ),
            .init(
                name: "Dress",
                price: 300,
                description: "Red",
                imageName: "figure.stand.dress"
            ),
            .init(
                name: "Knife",
                price: 300,
                description: "Black",
                imageName: "fork.knife"
            ),
            .init(
                name: "Pantyhose",
                price: 2000,
                description: "Red",
                imageName: "figure.walk.suitcase.rolling"
            ),
            .init(
                name: "Mate's Toilet",
                price: 4000,
                description: "Glejavoi",
                imageName: "toilet.fill"
            )
        ]
    }
}


