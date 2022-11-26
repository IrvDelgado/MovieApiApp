//
//  CrewPerson.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxSwift
import RxCocoa

final class CrewPerson: CreditsPersonModel {
    internal init(adult: Bool? = nil, gender: Int? = nil, id: Int, knownDepartment: String, name: String, originalName: String, popularity: Float? = nil, profilePath: Driver<UIImage>? = nil, creditId: String, department: String?, job: String?) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownDepartment = knownDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.creditId = creditId
        self.department = department
        self.job = job
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
    let department: String?
    let job: String?
}
