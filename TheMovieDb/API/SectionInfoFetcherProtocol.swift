//
//  SectionFetcherProtocol.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 22/01/22.
//

import RxSwift

// Sections could be loaded from firebase remoteconfig, storage, locally or other config desired
protocol sectionInfoFetcherProtocol {
    
    func getSectionInformation() -> BehaviorSubject<[(String, String)]>
}
