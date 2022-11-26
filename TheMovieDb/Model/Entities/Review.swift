//
//  Review.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation

struct Review: Codable {
    let author: String
    let authorDetails: AuthorDetail?
    let content: String
    let createdDate: String
    let id: String
    let updatedDate: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdDate = "created_at"
        case id
        case updatedDate = "updated_at"
        case url
    }
}
