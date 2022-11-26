//
//  FetchMovieCreditsUseCase.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 03/02/22.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkLayer

protocol FetchMovieCreditsUseCase {
    func invoke() throws -> Observable<MovieCreditsModel>
}

final class FetchMovieCreditsUseCaseImp {

    private var movieCreditsRequest: NetworkRequest
    
    struct Dependencies {
        let client: NetworkClient
        let movieId: Int
        let cacheManager: CacheManager

    }

    let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        let endpoint = String(format: AppConstants.API.creditsEndpoint, self.dependencies.movieId)

        let params = [AppConstants.API.params.apiKey: AppConstants.API.params.apiKeyValue,
                      AppConstants.API.params.language: "en"]
        
        movieCreditsRequest = NetworkRequest(method: RequestMethod.GET, path: endpoint, parameters: params, headers: AppConstants.API.jsonHeader)
    }
}

extension FetchMovieCreditsUseCaseImp: FetchMovieCreditsUseCase {
    
    func invoke() throws -> Observable<MovieCreditsModel> {
        
        var movieCredits: Observable<MovieCreditsModel>
        
        do {

            let movieCreditsResult: Observable<CreditsResult> = try self.dependencies.client.performRequestAndDecode(networkRequest: movieCreditsRequest)
            
            movieCredits = movieCreditsResult.map({ creditsResult  in
                
                let castArray: [CreditsPersonModel]  = creditsResult.cast.map({ [weak self] creditPerson in
                    guard let self = self else {
                        return CastPerson(
                            adult: nil,
                            gender: nil,
                            id: -1,
                            knownDepartment: "",
                            name: "",
                            originalName: "",
                            popularity: nil,
                            profilePath: nil,
                            creditId: "",
                            castId: nil,
                            character: nil,
                            order: nil)
                    }
                    
                    return self.getCastPersonModel(from: creditPerson)
                    
                })
                
                let crewArray: [CreditsPersonModel] = creditsResult.crew.map({ [weak self] creditPerson in
                    guard let self = self else {
                        return CrewPerson(
                            adult: nil,
                            gender: nil,
                            id: -1,
                            knownDepartment: "",
                            name: "",
                            originalName: "",
                            popularity: nil,
                            profilePath: nil,
                            creditId: "",
                            department: nil,
                            job: nil
                        )
                    }
                    
                    return self.getCrewPersonModel(from: creditPerson)
                    
                })
                
                let castDriver = Observable<[CreditsPersonModel]>.create { observer in
                    observer.onNext(castArray)
                    return Disposables.create()
                }.asDriver(onErrorJustReturn: [])
                
                let crewDriver = Observable<[CreditsPersonModel]>.create { observer in
                    observer.onNext(crewArray)
                    return Disposables.create()
                }.asDriver(onErrorJustReturn: [])

                return MovieCreditsModel(id: creditsResult.id, cast: castDriver, crew: crewDriver)
            })
            
        } catch {
  
            throw error
        }
        
        return movieCredits
        
    }
    
    func getCastPersonModel(from creditsPersonCodable: CreditsPerson) -> CreditsPersonModel {
        
        var profilePic: Driver<UIImage>?
        
        if let creditPic = creditsPersonCodable.profilePath {
            profilePic = fetchProfilePicture(imgpath: creditPic)
        }

        return CastPerson(
            adult: creditsPersonCodable.adult,
            gender: creditsPersonCodable.gender,
            id: creditsPersonCodable.id,
            knownDepartment: creditsPersonCodable.knownDepartment,
            name: creditsPersonCodable.name,
            originalName: creditsPersonCodable.originalName,
            popularity: creditsPersonCodable.popularity,
            profilePath: profilePic,
            creditId: creditsPersonCodable.creditId,
            castId: creditsPersonCodable.castId,
            character: creditsPersonCodable.character,
            order: creditsPersonCodable.order
        )
    }
    
    func getCrewPersonModel(from creditsPersonCodable: CreditsPerson) -> CreditsPersonModel {
        var profilePic: Driver<UIImage>?
        
        if let creditPic = creditsPersonCodable.profilePath {
            profilePic = fetchProfilePicture(imgpath: creditPic)
        }
        
        return CrewPerson(
            adult: creditsPersonCodable.adult,
            gender: creditsPersonCodable.gender,
            id: creditsPersonCodable.id,
            knownDepartment: creditsPersonCodable.knownDepartment,
            name: creditsPersonCodable.name,
            originalName: creditsPersonCodable.originalName,
            popularity: creditsPersonCodable.popularity,
            profilePath: profilePic,
            creditId: creditsPersonCodable.creditId,
            department: creditsPersonCodable.department,
            job: creditsPersonCodable.job
        )
    }
    
    // TODO: - abstract this method to a useCase and reuse in fetchMoviesUseCase too.
    func fetchProfilePicture(imgpath: String) -> Driver<UIImage> {
        
        let profilePath = AppConstants.API.posterSizes.medium + (imgpath)
        let profileRequest = NetworkRequest(method: RequestMethod.GET, path: profilePath, parameters: nil, headers: nil)
        let apiClient = ApiClient(baseUrl: URL(string: AppConstants.API.imgBaseUrl))

        var profileDriver: Driver<UIImage> = Observable.just(UIImage()).asDriver(onErrorJustReturn: UIImage())
        
        var shouldFetch = true

        if let cachedImg = self.dependencies.cacheManager.getFromCache(name: imgpath) {
            profileDriver = Observable.just(cachedImg).asDriver(onErrorJustReturn: cachedImg)
            shouldFetch = false
        }
        
        if shouldFetch {
            if let netClient = apiClient.networkClient {
                
                do {
                        
                    profileDriver = try netClient.fetchImage(networkRequest: profileRequest).map({[weak self]  image in
                        if let imgretrieved = image {
                            self?.dependencies.cacheManager.addToCache(image: imgretrieved, name: imgpath)
                        }
                        return image ?? UIImage()
                    }).asDriver(onErrorJustReturn: UIImage())
                    
                } catch {
                    
                    // TODO: - Add OsLog
                    print(error.localizedDescription)
                }

            }
        }
        
        return profileDriver
        
    }
    
}
