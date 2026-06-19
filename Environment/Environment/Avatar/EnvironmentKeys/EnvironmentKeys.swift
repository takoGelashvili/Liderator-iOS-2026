//
//  EnvironmentKeys.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct AvatarStyleKey: EnvironmentKey {
    static var defaultValue: AnyAvatarStyle = AnyAvatarStyle(AvatarHeaderStyle())
}

extension EnvironmentValues {
    var avatarStyle: AnyAvatarStyle {
        get {
            self[AvatarStyleKey.self]
        }
        set {
            self[AvatarStyleKey.self] = newValue
        }
    }
}
