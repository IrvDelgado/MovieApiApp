//
//  HomeViewModel.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 21/01/22.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkLayer

final class HomeViewModel {
    
    private let bag = DisposeBag()
    private let sectionFetcher: sectionInfoFetcherProtocol
    private var fetchMoviesUseCase: FetchMoviesModelUseCase?

    // MARK: - Input
    private var sectionFetcherBehaviorS: BehaviorSubject<[(String, String)]>
    // MARK: - Output
    private(set) var sections: Driver<[MoviesSection]>!
    
    // MARK: - Init
    init() {
    
        sectionFetcher = sectionInfoLocalFetcher()
        sectionFetcherBehaviorS = sectionFetcher.getSectionInformation()
        
        bindIO()
                
    }
    
    // MARK: - Methods
        
    private func bindIO() {
        sections =   sectionFetcherBehaviorS
                    .map({ sectionsInfoArray -> [MoviesSection] in

                        let movieSectionArray: [MoviesSection] =  sectionsInfoArray.map({[weak self] sectionInfo  -> MoviesSection in

                           // Getting Section information to perform request of movies in this section
                           let movieSection: MoviesSection
                           let sectionTitle = sectionInfo.0
                           let sectionPath = sectionInfo.1

                            let emptyMovieSection: MoviesSection = MoviesSection(sectionTitle: sectionTitle, Movies: Observable.just([]).asDriver(onErrorJustReturn: []))
                           
                            guard let self = self else { return emptyMovieSection}
                            
                           // Setting Network request/client to fetch list of movies
                            let params = [AppConstants.API.params.apiKey: AppConstants.API.params.apiKeyValue,
                                          AppConstants.API.params.language: "en",
                                          AppConstants.API.params.region: "US",
                                          AppConstants.API.params.page: "1"]
                            
                            let networkRequest = NetworkRequest(method: RequestMethod.GET, path: sectionPath, parameters: params, headers: AppConstants.API.jsonHeader)
                           
                           if let networkclient = ApiClient.shared.networkClient {

                               do {
                                            
                                   let usecaseDependencies = FetchMoviesModelUseCaseImp.Dependencies(networkclient: networkclient, networkRequest: networkRequest, cacheManager: CacheManager.shared)
                                   
                                   self.fetchMoviesUseCase = FetchMoviesModelUseCaseImp(dependencies: usecaseDependencies)

                                   let sectionMovies = try self.fetchMoviesUseCase!.invoke().asDriver(onErrorJustReturn: [])
                                       
                                   movieSection = MoviesSection(sectionTitle: sectionTitle, Movies: sectionMovies)
                                   
                               } catch {
                                   movieSection = emptyMovieSection
                               }

                           } else {
                               movieSection = emptyMovieSection
                           }
                           
                           return movieSection
                        })
                    
                        return movieSectionArray
                    })
                    .asDriver(onErrorJustReturn: [])
    }
      
}
