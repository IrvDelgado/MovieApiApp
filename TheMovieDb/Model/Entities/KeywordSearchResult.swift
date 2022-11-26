//
//  KeywordSearchResult.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 30/01/22.
//

import Foundation

struct KeywordSearchResult: Codable {
    let page: Int
    let keywordGroups: [KeywordInfo]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case keywordGroups = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}

struct KeywordInfo: Codable {
    let name: String
    let id: Int
}
