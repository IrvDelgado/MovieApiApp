//
//  MovieCreditsModel.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxCocoa
import RxSwift

struct MovieCreditsModel {
    let id: Int
    let cast: Driver<[CreditsPersonModel]>
    let crew: Driver<[CreditsPersonModel]>
}
