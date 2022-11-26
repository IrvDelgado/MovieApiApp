//
//  PerformKeywordSearchUseCase.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 30/01/22.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkLayer

protocol PerformKeywordSearchUseCase {
    func invoke() -> Observable<[MoviesSection]>
}

final class PerformKeywordSearchUseCaseImp {

    private var searchRequest: NetworkRequest
    private var fetchMoviesUseCase: FetchMoviesModelUseCase?
    
    struct Dependencies {
        let client: NetworkClient
        let searchText: String
    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
        let params = [AppConstants.API.params.apiKey: AppConstants.API.params.apiKeyValue,
                      AppConstants.API.params.language: "en",
                      AppConstants.API.params.query: self.dependencies.searchText]
        
        searchRequest = NetworkRequest(method: RequestMethod.GET, path: AppConstants.API.keywordSearchEndpoint, parameters: params, headers: AppConstants.API.jsonHeader)
        
    }
}

extension PerformKeywordSearchUseCaseImp: PerformKeywordSearchUseCase {

    func invoke() -> Observable<[MoviesSection]> {

        // Fetch sections
        
        do {
            let keywordSearchObservableResult: Observable<KeywordSearchResult> = try self.dependencies.client.performRequestAndDecode(networkRequest: searchRequest)
            
            let moviesarrayObservable: Observable<[MoviesSection]> = keywordSearchObservableResult.map({[weak self]  keywordResult in
                
                guard let self = self else { return [] }
                
                var movieSectionArray: [MoviesSection] = []
                
                for keywordInfo in keywordResult.keywordGroups {
                    
                    var searchMovies: Driver<[MovieModel]>
                    
                    do {
                        
                        let keywordPath = String(format: AppConstants.API.keywordMoviesEndpoint, keywordInfo.id)
                        let params = [AppConstants.API.params.apiKey: AppConstants.API.params.apiKeyValue,
                                      AppConstants.API.params.language: "en"]
                        
                        let moviesRequest = NetworkRequest(method: RequestMethod.GET, path: keywordPath, parameters: params, headers: AppConstants.API.jsonHeader)

                        let usecaseDependencies = FetchMoviesModelUseCaseImp.Dependencies(networkclient: self.dependencies.client, networkRequest: moviesRequest, cacheManager: CacheManager.shared)
                        
                        self.fetchMoviesUseCase = FetchMoviesModelUseCaseImp(dependencies: usecaseDependencies)

                        searchMovies = try self.fetchMoviesUseCase!.invoke().asDriver(onErrorJustReturn: [])
                        
                    } catch {
                        return []
                    }
                    
                    let section: MoviesSection = MoviesSection(sectionTitle: keywordInfo.name, Movies: searchMovies)
                    movieSectionArray.append(section)
                }
                
                return movieSectionArray
            })
            
            return moviesarrayObservable
        } catch {
            
            return Observable<[MoviesSection]>.create { observer in
                observer.onNext([])
                return Disposables.create()
            }
            
        }
    }
    
}
