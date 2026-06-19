//
//  ProfilePicture.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct ProfilePicture: View {
    let isActive: Bool
    let imageName: String
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: size / 20)
            if !isActive {
                Circle()
                    .foregroundStyle(.black.opacity(0.3))
            }
            Image(systemName: imageName)
                .resizable()
                .frame(width: size * 2/3, height: size * 2/3)
        
            activityIndicator
                .offset(x: size / 2.4, y: -size / 3)

        }
        .frame(width: size)
    }
    
    var activityIndicator: some View {
        Circle()
            .frame(width: size / 4.5)
            .foregroundStyle(isActive ? .green : .red)
    }
}

#Preview {
    ProfilePicture(isActive: false, imageName: "person", size: 200)
}
