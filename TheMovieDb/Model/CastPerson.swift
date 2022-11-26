//
//  CastPerson.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxCocoa
import RxSwift

final class CastPerson: CreditsPersonModel {
    
    internal init(adult: Bool? = nil, gender: Int? = nil, id: Int, knownDepartment: String, name: String, originalName: String, popularity: Float? = nil, profilePath: Driver<UIImage>? = nil, creditId: String, castId: Int?, character: String?, order: Int?) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownDepartment = knownDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.creditId = creditId
        self.castId = castId
        self.character = character
        self.order = order
    }
    
    var adult: Bool?
    var gender: Int?
    var id: Int
    var knownDepartment: String
    var name: String
    var originalName: String
    var popularity: Float?
    var profilePath: Driver<UIImage>?
    var creditId: String
    let castId: Int?
    let character: String?
    let order: Int?
}
