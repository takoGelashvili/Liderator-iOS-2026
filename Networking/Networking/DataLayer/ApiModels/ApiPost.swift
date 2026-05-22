//
//  ApiPost.swift
//  Networking
//
//  Created by Tamar Gelashvili on 22/05/2026.
//

struct ApiPost: Decodable {
    let userId: Int?
    let id: Int?
    let title: String?
    let body: String?
    
    //let status: String? // SUCCESS/ERROR/PENDING
    
    var toModel: Post? {
        guard
            let userId,
            let id,
            let title
//            let status = status,
//            let statusEnum = Status(rawValue: status)
        else { return nil }
        
        return Post(
            userId: userId,
            id: id,
            title: title,
            body: body
            //status: statusEnum
        )
    }
}
