//
//  MovieDetail.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
struct MovieDetail: Codable {
    
    let id: Int
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let imdbId: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case budget
        case genres
        case homepage
        case imdbId = "imdb_id"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
    }

}
