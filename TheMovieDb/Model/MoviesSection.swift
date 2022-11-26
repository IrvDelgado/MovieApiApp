//
//  MoviesSection.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 21/01/22.
//

import Foundation
import RxCocoa

struct MoviesSection {
    let sectionTitle: String
    var Movies: Driver<[MovieModel]>
}
