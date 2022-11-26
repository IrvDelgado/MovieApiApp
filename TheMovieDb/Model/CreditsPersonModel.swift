//
//  CreditsPersonModel.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol CreditsPersonModel {
    var adult: Bool? { get }
    var gender: Int? { get }
    var id: Int { get }
    var knownDepartment: String { get }
    var name: String { get }
    var originalName: String { get }
    var popularity: Float? { get }
    var profilePath: Driver<UIImage>? { get }
    var creditId: String { get }
    
}
