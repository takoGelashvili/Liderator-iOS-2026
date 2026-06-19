//
//  AvatarInlineStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct AvatarInlineStyle: AvatarStyle {
    func makeBody(with configuration: AvatarConfiguration) -> some View {
        HStack(spacing: 12) {
            ProfilePicture(
                isActive: true,
                imageName: configuration.imageName,
                size: 50
            )
            
            Text(configuration.name)
                .font(.title)
                .bold()
            
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
    .avatarStyle(.inline)
}
