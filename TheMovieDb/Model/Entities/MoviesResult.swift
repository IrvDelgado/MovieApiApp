//
//  MoviesResult.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 26/01/22.
//

import Foundation

struct MoviesResult: Codable {
    let id: Int?
    let page: Int?
    let movies: [Movie]
    let totalResults: Int
    let totalPages: Int
    enum CodingKeys: String, CodingKey {
        case id
        case page
        case movies = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

}
