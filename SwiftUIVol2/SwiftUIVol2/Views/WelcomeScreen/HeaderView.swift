//
//  HeaderView.swift
//  SwiftUIVol2
//
//  Created by Tamar Gelashvili on 10/06/2026.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "larisign.bank.building")
                .resizable()
                .frame(width: 70,
                       height: 70)
            VStack {
                Text("Welcome to")
                Text("BOG")
                    .font(.largeTitle)
            }
            .bold()
        }
        .foregroundStyle(.orange)
    }
}
