//
//  AvatarView.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct AvatarView: View {
    let configuration: AvatarConfiguration
    @Environment(\.avatarStyle) var avatarStyle
    
    var body: some View {
        avatarStyle.makeBody(with: configuration)
    }
}
