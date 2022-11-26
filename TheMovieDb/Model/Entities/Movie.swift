//
//  Movie.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 21/01/22.
//

import Foundation

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let budget: Int?
    let genreIds: [Int]?
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String
    let originalTitle: String
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let voteCount: Int
    let video: Bool
    let voteAverage: Float
    let title: String
    let overview: String
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let popularity: Float
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genreIds = "genre_ids"
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
        case title
        case overview
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case popularity
    }

}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logo_path: String?
    let name: String?
    let origin_country: String?
}

struct ProductionCountry: Codable {
    let iso: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso = "iso_3166_1"
        case name
    }

}

struct SpokenLanguage: Codable {
    let englishName: String
    let iso: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso = "iso_3166_1"
        case name
    }
    
}
