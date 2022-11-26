//
//  MovieDetailViewModel.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 01/02/22.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkLayer

final class MovieDetailViewModel {
    private let bag = DisposeBag()

    private var fetchMovieDetail: FetchMovieDetailModelUseCase?
    private var movieCreditsFetcher: FetchMovieCreditsUseCase?
    private var reviewsFetcher: FetchMovieReviewsUseCase?
    var reviewsArray: [Review] = []
    private var similarMoviesFetcher: FetchSimilarMoviesUseCase?
    private var recommendedMoviesFetcher: FetchRecommendedMoviesUseCase?
    
    private var detailesFetched: Bool = false
    private var networkclient: NetworkClient
    
    // MARK: Input
    private(set) var movie: MovieModel
    
    // MARK: Output
    private(set) var movieInfo: BehaviorRelay<MovieModel>?
    private(set) var movieCredits: Observable<MovieCreditsModel>?
    private(set) var movieReviews: Observable<[Review]>?
    private(set) var otherMoviesSection: BehaviorRelay<[MoviesSection]>?
    
    init(movie: MovieModel) {
        self.movie = movie
   
        detailesFetched = self.movie.movieDetails != nil
        
        networkclient = ApiClient.shared.networkClient ?? NetworkClient(baseURL: URL(string: AppConstants.API.baseURL)!)

        bindOutput()
    }
    
    private func bindOutput() {
        
        if !detailesFetched {
            
            // If there isn't additional info try to fetch it
            do {
                
                self.fetchMovieDetail = FetchMovieDetailModelUseCaseImp(dependencies: FetchMovieDetailModelUseCaseImp.Dependencies(networkclient: networkclient, movieId: self.movie.id))
                
                self.movie.movieDetails = try self.fetchMovieDetail!.invoke()
                
            } catch {
                print( error.localizedDescription )
            }
            detailesFetched = true
        }
        
        // then Output movie information
        movieInfo = BehaviorRelay<MovieModel>(value: self.movie)
        
        // Getting movie Credits
        movieCreditsFetcher = FetchMovieCreditsUseCaseImp(dependencies: FetchMovieCreditsUseCaseImp.Dependencies(client: self.networkclient, movieId: self.movie.id, cacheManager: CacheManager.shared))
        
        do { movieCredits = try movieCreditsFetcher!.invoke() } catch { print(error.localizedDescription )}
        
        // Fetching movie Reviews
        reviewsFetcher = FetchMovieReviewsUseCaseImp(dependencies: FetchMovieReviewsUseCaseImp.Dependencies(client: self.networkclient, movieId: self.movie.id))
        
        movieReviews = reviewsFetcher!.invoke()

        // Fetching similar movies
        similarMoviesFetcher = FetchSimilarMoviesUseCaseImp(dependencies: FetchSimilarMoviesUseCaseImp.Dependencies(client: self.networkclient, movieId: self.movie.id))
        // Fetching Recommended movies
        recommendedMoviesFetcher = FetchRecommendedMoviesUseCaseImp(dependencies: FetchRecommendedMoviesUseCaseImp.Dependencies(client: self.networkclient, movieId: self.movie.id))
            
        let similar =  similarMoviesFetcher!.invoke().asDriver(onErrorJustReturn: [])
        let similarMoviesSection = MoviesSection(sectionTitle: AppConstants.API.similarSection.0, Movies: similar)
        
        let recommended =  recommendedMoviesFetcher!.invoke().asDriver(onErrorJustReturn: [])
        let recommendedMoviesSection = MoviesSection(sectionTitle: AppConstants.API.recommendedSection.0, Movies: recommended)
        
        let movieSectionArray: [MoviesSection] = [similarMoviesSection, recommendedMoviesSection]
        
        otherMoviesSection = BehaviorRelay<[MoviesSection]>(value: movieSectionArray)
        
    }
    
}
