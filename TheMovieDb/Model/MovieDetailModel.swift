//
//  MovieDetailModel.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation

struct MovieDetailModel {
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
}
