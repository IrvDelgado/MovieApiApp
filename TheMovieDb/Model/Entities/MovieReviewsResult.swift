//
//  MovieReviewsResult.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation

struct MovieReviewsResult: Codable {
    let page: Int
    let reviews: [Review]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case reviews = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}
