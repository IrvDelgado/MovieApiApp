//
//  fetchMoviesModelUseCase.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 30/01/22.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkLayer

protocol FetchMoviesModelUseCase {
    func invoke() throws -> Observable<[MovieModel]>
}

final class FetchMoviesModelUseCaseImp {
    
    struct Dependencies {
        let networkclient: NetworkClient
        let networkRequest: NetworkRequest
        let cacheManager: CacheManager
    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        
    }
}

extension FetchMoviesModelUseCaseImp: FetchMoviesModelUseCase {

    func invoke() throws -> Observable<[MovieModel]> {

        do {
            let moviesRequestObservableResult: Observable<MoviesResult> = try self.dependencies.networkclient.performRequestAndDecode(networkRequest: self.dependencies.networkRequest)

            // Transforming moviesRequestObservableResult to get only the list of movies as observable
            let movies: Observable<[MovieModel]> =
            moviesRequestObservableResult.map({ movieResult in
                return movieResult.movies
                    .map({ [weak self] movie in
                        guard let self = self else {

                            return MovieModel(
                                adult: false,
                                backdropImg: Observable.just(nil).asDriver(onErrorJustReturn: nil),
                                genreIds: nil,
                                id: -1,
                                originalLanguage: "",
                                originalTitle: "",
                                posterImg: Observable.just(nil).asDriver(onErrorJustReturn: nil),
                                voteCount: 0, video: false,
                                voteAverage: 0.0, title: "",
                                overview: "",
                                releaseDate: nil,
                                popularity: 0.0,
                                movieDetails: nil
                            )
                            
                        }
                        
                        return self.getMovieModel(from: movie)
                })
            })
            
            return movies
        } catch {
            throw error
        }
    }
    
    private func getMovieModel(from movie: Movie) -> MovieModel {

        let backdropPath = AppConstants.API.backdropSizes.medium + (movie.backdropPath ?? "")
        let backdropRequest = NetworkRequest(method: RequestMethod.GET, path: backdropPath, parameters: nil, headers: nil)
        
        let posterPath = AppConstants.API.posterSizes.medium + (movie.posterPath ?? "")
        let PosterRequest = NetworkRequest(method: RequestMethod.GET, path: posterPath, parameters: nil, headers: nil)
        
        let apiClient = ApiClient(baseUrl: URL(string: AppConstants.API.imgBaseUrl))

        var backdropDriver: Driver<UIImage?> = Observable.just(nil).asDriver(onErrorJustReturn: nil)
        var posterDriver: Driver<UIImage?> = Observable.just(nil).asDriver(onErrorJustReturn: nil)
        
        var shouldFetchBackdrop = true
        var shouldFetchPoster = true

        if  movie.backdropPath != nil {
            // Is the image in cache?
            if let cachedImg = self.dependencies.cacheManager.getFromCache(name: (String(movie.id) + "backdrop")) {
                backdropDriver = Observable.just(cachedImg).asDriver(onErrorJustReturn: nil)
                shouldFetchBackdrop = false
            }

        }
        if movie.posterPath != nil {
            if let cachedPoster = self.dependencies.cacheManager.getFromCache(name: (String(movie.id) + "poster")) {
                posterDriver = Observable.just(cachedPoster).asDriver(onErrorJustReturn: nil)

                shouldFetchPoster = false
            }
        }

            // if so take it from cache, otherwise fetch and add to cache
        
        if  shouldFetchBackdrop || shouldFetchPoster {
            
            if let netClient = apiClient.networkClient {
                
                do {
                    
                    if shouldFetchBackdrop {
                        
                        backdropDriver = try netClient.fetchImage(networkRequest: backdropRequest).map({[weak self]  image in
                            if let imgretrieved = image {
                                self?.dependencies.cacheManager.addToCache(image: imgretrieved, name: (String(movie.id) + "backdrop"))
                            }
                            return image
                        }).asDriver(onErrorJustReturn: nil)

                    }
 
                    if shouldFetchPoster {

                        posterDriver = try netClient.fetchImage(networkRequest: PosterRequest).map({[weak self]  image in
                            if let imgretrieved = image {
                                self?.dependencies.cacheManager.addToCache(image: imgretrieved, name: (String(movie.id) + "poster"))
                            }
                            return image
                        })
                            .asDriver(onErrorJustReturn: nil)
                        
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }

            }
        
        }
        
        return MovieModel(adult: movie.adult,
                          backdropImg: backdropDriver,
                          genreIds: movie.genreIds,
                          id: movie.id,
                          originalLanguage: movie.originalLanguage,
                          originalTitle: movie.originalTitle,
                          posterImg: posterDriver,
                          voteCount: movie.voteCount,
                          video: movie.video,
                          voteAverage: movie.voteAverage,
                          title: movie.title,
                          overview: movie.overview,
                          releaseDate: movie.releaseDate,
                          popularity: movie.popularity,
                          movieDetails: nil)
         
    }

}
