//
//  Models.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 15.07.2022.
//

import Foundation

struct Results: Codable {
    let posts: [Post]
}

struct Post: Codable {
    let postId: Int
    let title: String
    let preview_text: String
    let likes_count: Int
    var timeshamp: Double
}
