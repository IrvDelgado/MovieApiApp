//
//  MovieModel.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 26/01/22.
//

import RxCocoa
import RxSwift

struct MovieModel {
    let adult: Bool
    let backdropImg: Driver<UIImage?>
    let genreIds: [Int]?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let posterImg: Driver<UIImage?>
    let voteCount: Int
    let video: Bool
    let voteAverage: Float
    let title: String
    let overview: String
    let releaseDate: String?
    let popularity: Float
    
    var movieDetails: Observable<MovieDetailModel>?
}
