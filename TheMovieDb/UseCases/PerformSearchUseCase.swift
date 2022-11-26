//
//  performSearchUseCase.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 30/01/22.
//

import Foundation
import RxSwift
import NetworkLayer

protocol PerformSearchUseCase {
    func invoke() -> Observable<[MovieModel]>
}

final class PerformSearchUseCaseImp {

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
        
        searchRequest = NetworkRequest(method: RequestMethod.GET, path: AppConstants.API.searchEndpoint, parameters: params, headers: AppConstants.API.jsonHeader)
        
    }
}

extension PerformSearchUseCaseImp: PerformSearchUseCase {

    func invoke() -> Observable<[MovieModel]> {

        var searchMovies: Observable<[MovieModel]>
        do {
            let usecaseDependencies = FetchMoviesModelUseCaseImp.Dependencies(networkclient: self.dependencies.client, networkRequest: self.searchRequest, cacheManager: CacheManager.shared)
            
            self.fetchMoviesUseCase = FetchMoviesModelUseCaseImp(dependencies: usecaseDependencies)

            searchMovies = try self.fetchMoviesUseCase!.invoke()
            
        } catch {
            return Observable<[MovieModel]>.create { observer in
                
                observer.onNext([])
                
                return Disposables.create()
                
            }
        }
        
        return searchMovies
    }
}
