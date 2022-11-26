//
//  CreditsSection.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxCocoa

struct CreditsSection {
    let sectionTitle: String
    var creditsPeople: Driver<[CreditsPerson]>
}
