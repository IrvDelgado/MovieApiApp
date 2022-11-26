//
//  sectionLocalFetcher.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 22/01/22.
//

import RxSwift

final class sectionInfoLocalFetcher: sectionInfoFetcherProtocol {
    
    func getSectionInformation() -> BehaviorSubject<[(String, String)]> {
        return BehaviorSubject<[(String, String)]>(value: AppConstants.API.sectionInfo)
    }
}
