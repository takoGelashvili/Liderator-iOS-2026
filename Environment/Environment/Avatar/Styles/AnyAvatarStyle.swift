//
//  AnyAvatarStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

extension View {
    func avatarStyle(_ style: AnyAvatarStyle) -> some View {
        environment(\.avatarStyle, style)
    }
}

final class AnyAvatarStyle: AvatarStyle {
    //private let _makeBody: (AvatarConfiguration) -> AnyView
    private let style: any AvatarStyle
    
    init<S: AvatarStyle>(_ style: S) {
//        self._makeBody = { configuration in
//            AnyView(style.makeBody(with: configuration))
//        }
        self.style = style
    }
    
    func makeBody(with configuration: AvatarConfiguration) -> AnyView {
        //_makeBody(configuration)
        AnyView(style.makeBody(with: configuration))
    }
}

extension AnyAvatarStyle {
    static let header = AnyAvatarStyle(AvatarHeaderStyle())
    static let inline = AnyAvatarStyle(AvatarInlineStyle())
    static let offline = AnyAvatarStyle(AvatarOfflineStyle())
}
