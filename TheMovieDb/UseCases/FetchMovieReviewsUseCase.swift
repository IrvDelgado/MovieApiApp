//
//  FetchMovieReviewsUseCase.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation

import Foundation
import RxSwift
import NetworkLayer

protocol FetchMovieReviewsUseCase {
    func invoke() -> Observable<[Review]>
}

final class FetchMovieReviewsUseCaseImp {

    private var movieReviewsRequest: NetworkRequest
    
    struct Dependencies {
        let client: NetworkClient
        let movieId: Int
    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        let endpoint = String(format: AppConstants.API.reviewsSection.1, self.dependencies.movieId)

        let params = [AppConstants.API.params.apiKey: AppConstants.API.params.apiKeyValue,
                      AppConstants.API.params.language: "en"]
        
        movieReviewsRequest = NetworkRequest(method: RequestMethod.GET, path: endpoint, parameters: params, headers: AppConstants.API.jsonHeader)
    }
}

extension FetchMovieReviewsUseCaseImp: FetchMovieReviewsUseCase {

    func invoke() -> Observable<[Review]> {

        var movieReviews: Observable<[Review]>
        do {

            let movieReviewsResult: Observable<MovieReviewsResult> = try self.dependencies.client.performRequestAndDecode(networkRequest: movieReviewsRequest)
            
            movieReviews = movieReviewsResult.map({ reviewsResult in
                reviewsResult.reviews
            })
            
        } catch {
            return Observable<[Review]>.create { observer in
                
                observer.onNext([])
                
                return Disposables.create()
                
            }
        }
        
        return movieReviews
    }
}
