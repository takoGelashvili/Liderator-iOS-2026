//
//  CartView.swift
//  Observable
//
//  Created by Tamar Gelashvili on 17/06/2026.
//

import SwiftUI

struct CartView: View {
    @State var vm: CartViewModel
    @State var isSheetPresented: Bool = false
    
    let columns: [GridItem] = [
        .init(spacing: 30),
        .init(spacing: 30)
    ]
    
    var body: some View {
        ScrollView {
            CartCircleView(numOfItems: vm.state.itemsInCart.count)
                .onTapGesture {
                    isSheetPresented = true
                }
            LazyVGrid(columns: columns) {
                ForEach(vm.state.items, id: \.self) { item in
                    ItemView(item: item, vm: vm)
                        .padding(.vertical, 10)
                }
            }
        }
        .sheet(isPresented: $isSheetPresented, content: {
            CartInsideView()
        })
        .padding(.horizontal, 30)
        .task {
            trackCart()
            await vm.onLoad()
        }
    }
    
    private func trackCart() {
        withObservationTracking {
            _ = vm.state.itemsInCart.count
        } onChange: {
            print("ITEM COUNT BECAME ONE")
            trackCart()
        }
    }
}

struct CartCircleView: View {
    let numOfItems: Int
    
    var body: some View {
        Circle()
            .foregroundStyle(.red)
            .frame(width: 100)
            .overlay {
                Image(systemName: "cart.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .overlay {
                if numOfItems > 0 {
                    countCircle
                }
            }
    }
    
    var countCircle: some View {
        ZStack {
            Circle()
                .frame(width: 40)
                .foregroundStyle(.green)
            Text("\(numOfItems)")
        }
        .offset(x: 40, y: -33)
    }
}

struct ItemView: View {
    let item: CartItem
    let vm: CartViewModel
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 180)
            .foregroundStyle(.red.opacity(0.2))
            .overlay {
                VStack {
                    Image(systemName: item.imageName)
                        .resizable()
                        .frame(width: 40, height: 50)
                        .foregroundStyle(.white)
                    Text(item.name)
                    Text(item.description)
                    Text(String(item.price))
                    
                    Button("Add to cart") {
                        vm.handleIntent(.didTapItem(item: item))
                    }.buttonStyle(.borderedProminent)
                        .tint(.primary)
                }
            }
    }
}

#Preview {
    CartView(vm: CartViewModelImpl(useCase: ItemsUseCaseImpl()))
}
