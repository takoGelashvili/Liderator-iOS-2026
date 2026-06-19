//
//  AvatarStyle.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

protocol AvatarStyle {
    associatedtype ViewToReturn: View
    func makeBody(with configuration: AvatarConfiguration) -> ViewToReturn
}
