//
//  CreditsResult.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation

struct CreditsResult: Codable {
    let id: Int
    let cast: [CreditsPerson]
    let crew: [CreditsPerson]
}

struct CreditsPerson: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int
    let knownDepartment: String
    let name: String
    let originalName: String
    let popularity: Float?
    let profilePath: String?
    let creditId: String
    
    // Cast only attributes
    let castId: Int?
    let character: String?
    let order: Int?
    
    // Crew only attributes
    let department: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case creditId = "credit_id"
        case castId
        case character
        case order
        case department
        case job
        
    }
}
