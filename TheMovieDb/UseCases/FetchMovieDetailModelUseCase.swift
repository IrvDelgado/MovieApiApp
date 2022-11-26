//
//  FetchMovieDetailModelUseCase.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxSwift
import NetworkLayer

protocol FetchMovieDetailModelUseCase {
    func invoke() throws -> Observable<MovieDetailModel>
}

final class FetchMovieDetailModelUseCaseImp {
    
    private var movieRequest: NetworkRequest

    struct Dependencies {
        let networkclient: NetworkClient
        let movieId: Int
    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        let endpoint = String(format: AppConstants.API.movieEndpoint, self.dependencies.movieId)

        let params = [AppConstants.API.params.apiKey: AppConstants.API.params.apiKeyValue,
                      AppConstants.API.params.language: "en"]
        
        movieRequest = NetworkRequest(method: RequestMethod.GET, path: endpoint, parameters: params, headers: AppConstants.API.jsonHeader)
    }
}

extension FetchMovieDetailModelUseCaseImp: FetchMovieDetailModelUseCase {
    
    func invoke() throws -> Observable<MovieDetailModel> {
        do {
            let movieDetailResult: Observable<MovieDetail> = try self.dependencies.networkclient.performRequestAndDecode(networkRequest: movieRequest)
            
            let movieDetailToModel: Observable<MovieDetailModel> = movieDetailResult.map({ [weak self] movieDet in
                guard let self = self else {
                    return MovieDetailModel(budget: nil,
                                            genres: nil,
                                            homepage: nil,
                                            imdbId: nil,
                                            productionCompanies: nil,
                                            productionCountries: nil,
                                            revenue: nil,
                                            runtime: nil,
                                            spokenLanguages: nil,
                                            status: nil,
                                            tagline: nil)
                }
                return self.getMovieDetailModel(from: movieDet)
            })
            
            return movieDetailToModel
            
        } catch {

            throw error
            
        }
    }
    
    private func getMovieDetailModel(from movieDetail: MovieDetail) -> MovieDetailModel {
        return MovieDetailModel(budget: movieDetail.budget,
                                genres: movieDetail.genres,
                                homepage: movieDetail.homepage,
                                imdbId: movieDetail.imdbId,
                                productionCompanies: movieDetail.productionCompanies,
                                productionCountries: movieDetail.productionCountries,
                                revenue: movieDetail.revenue,
                                runtime: movieDetail.runtime,
                                spokenLanguages: movieDetail.spokenLanguages,
                                status: movieDetail.status,
                                tagline: movieDetail.tagline)
    }
}
