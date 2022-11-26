//
//  FetchSimilarMoviesUseCase.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxSwift
import NetworkLayer

protocol FetchSimilarMoviesUseCase {
    func invoke() -> Observable<[MovieModel]>
}

final class FetchSimilarMoviesUseCaseImp {

    private var similarMoviesRequest: NetworkRequest
    private var fetchMoviesUseCase: FetchMoviesModelUseCase?
    
    struct Dependencies {
        let client: NetworkClient
        let movieId: Int
    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        let endpoint = String(format: AppConstants.API.similarSection.1, self.dependencies.movieId)

        let params = [AppConstants.API.params.apiKey: AppConstants.API.params.apiKeyValue,
                      AppConstants.API.params.language: "en"]
        
        similarMoviesRequest = NetworkRequest(method: RequestMethod.GET, path: endpoint, parameters: params, headers: AppConstants.API.jsonHeader)
    }
}

extension FetchSimilarMoviesUseCaseImp: FetchSimilarMoviesUseCase {

    func invoke() -> Observable<[MovieModel]> {

        var similarMovies: Observable<[MovieModel]>
        do {
            let usecaseDependencies = FetchMoviesModelUseCaseImp.Dependencies(networkclient: self.dependencies.client, networkRequest: self.similarMoviesRequest, cacheManager: CacheManager.shared)
            
            self.fetchMoviesUseCase = FetchMoviesModelUseCaseImp(dependencies: usecaseDependencies)

            similarMovies = try self.fetchMoviesUseCase!.invoke()
            
        } catch {
            return Observable<[MovieModel]>.create { observer in
                
                observer.onNext([])
                
                return Disposables.create()
                
            }
        }
        
        return similarMovies
    }
}
