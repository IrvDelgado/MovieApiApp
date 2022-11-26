//
//  ReviewsSection.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//
import Foundation
import RxCocoa

struct ReviewsSection {
    let sectionTitle: String
    var reviews: Driver<[Review]>
}
