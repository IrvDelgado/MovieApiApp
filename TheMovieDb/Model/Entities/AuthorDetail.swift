//
//  AuthorDetail.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation

struct AuthorDetail: Codable {
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}
