//
//  AvatarOfflineStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct AvatarOfflineStyle: AvatarStyle {
    func makeBody(with configuration: AvatarConfiguration) -> some View {
        HStack(spacing: 12) {
            ProfilePicture(
                isActive: false,
                imageName: configuration.imageName,
                size: 50
            )
            
            VStack(alignment: .leading) {
                Text(configuration.name)
                    .font(.title)
                    .bold()
                Text("Offline")
            }
            .foregroundStyle(.gray)
            
            Spacer()
            
            CustomButtonView(buttonConfiguration: .init(
                iconName: "person",
                buttonAction: configuration.buttonAction
            ))
            .customButtonStyle(.small)
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    AvatarView(
        configuration: .init(
            name: "Jon doe",
            imageName: "person",
            buttonAction: {
        print("LLALAL")
    }))
    .avatarStyle(.offline)
}
