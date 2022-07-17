//
//  Models.swift
//  NatifeProject
//
//  Created by Ivan Pestov on 15.07.2022.
//

import Foundation

struct Result: Codable {
    let posts: [Post]
}

struct Post: Codable, Comparable {
    static func < (lhs: Post, rhs: Post) -> Bool {
        true
    }
    
    
    
    
    let title: String
    let preview_text: String
    let likes_count: Int
    let timeshamp: Date
}
