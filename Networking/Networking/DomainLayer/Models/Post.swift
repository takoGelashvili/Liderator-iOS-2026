//
//  Post.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

struct Post {
    let userId: Int
    let id: Int
    let title: String
    let body: String?
    
    //let status: Status
}

enum Status: String {
    case success = "SUCCESS"
    case error = "ERROR"
    case pending = "PENDING"
}
