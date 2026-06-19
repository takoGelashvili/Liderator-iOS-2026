//
//  AvatarHeaderStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct AvatarHeaderStyle: AvatarStyle {
    func makeBody(with configuration: AvatarConfiguration) -> some View {
        VStack {
            ProfilePicture(
                isActive: true,
                imageName: configuration.imageName,
                size: 100
            )
            
            Text(configuration.name)
                .font(.largeTitle)
                .bold()
            
            CustomButtonView(buttonConfiguration: .init(
                iconName: "person",
                title: "Profile",
                buttonAction: configuration.buttonAction
            ))
        }
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
}
