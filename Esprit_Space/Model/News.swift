//
//  News.swift
//  Esprit_Space
//
//  Created by safa on 5/5/2023.
//

import Foundation

struct NewsPost: Codable, Identifiable {
    let id: String
    let title: String
    let description: String
    let content: String
    let author: String
    let imageUrl: String
    let iduser: String?
    var comment: [Comment]? = []

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case description
        case author
        case content
        case imageUrl
        case iduser = "iduser"
        case comment
    }
    
    struct Comment: Codable, Identifiable {
        let commentAuthor: String
        let commentContent: String
        let id: String
        //let postId: String
        let timestamp: Date
    }
}
