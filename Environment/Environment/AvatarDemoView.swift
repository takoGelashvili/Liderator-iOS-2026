//
//  AvatarDemoView.swift
//  Environment
//
//  Created by Tamar Gelashvili on 19/06/2026.
//

import SwiftUI

struct AvatarDemoView: View {
    @State var swipeStyle: AnyAvatarStyle = .header
    
    let configuration = AvatarConfiguration(
        name: "ჯონდო",
        imageName:"person",
        buttonAction: {
            print("TAPPED")
        }
    )
    
    var body: some View {
        List {
            Section("Header Style") {
                AvatarView(configuration: configuration)
                    .avatarStyle(.header)
            }
            
            Section("Inline Style") {
                AvatarView(configuration: configuration)
                    .avatarStyle(.inline)
            }
            
            Section("Offline Style") {
                AvatarView(configuration: configuration)
                    .avatarStyle(.offline)
            }
            
            Section("Style Swap") {
                AvatarView(configuration: configuration)
                    .avatarStyle(swipeStyle)
                
                HStack {
                    Button("Header") {
                        swipeStyle = .header
                    }
                    
                    Button("Inline") {
                        swipeStyle = .inline
                    }
                    
                    Button("Offline") {
                        swipeStyle = .offline
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    AvatarDemoView()
}
