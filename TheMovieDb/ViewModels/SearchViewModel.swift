//
//  SearchViewModel.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 29/01/22.
//

import Foundation
import RxSwift
import RxCocoa
import NetworkLayer

final class SearchViewModel {
    private let bag = DisposeBag()

    private var doRegularSearch: PerformSearchUseCase?
    private var doKeywordSearch: PerformKeywordSearchUseCase?
    
    // Input
    private(set) var textToSearch: PublishRelay<String>
    private(set) var isAQuerySearch: BehaviorRelay<Bool>

    // output
    private(set) var moviesSearch: PublishRelay<[MovieModel]>
    private(set) var keywordSections: PublishRelay<[MoviesSection]>

    init(searchText: PublishRelay<String>, searchTypeStatus: BehaviorRelay<Bool>) {
        self.textToSearch = searchText
        self.isAQuerySearch = searchTypeStatus
        self.moviesSearch = PublishRelay<[MovieModel]>()
        self.keywordSections = PublishRelay<[MoviesSection]>()
        
        bindInput()
    }
    
    private func bindInput() {
        
        // Whenever there is a change in the inputs, the search changes
        Observable.combineLatest(textToSearch, isAQuerySearch)
            .bind { [weak self] textFieldInput, searchTypeButtonValue in
                guard let self = self else { return }

                let searchmodeString = searchTypeButtonValue ? "keyword" : "Query"

                // TODO: - Handle string validations (empty, etc)

                if let networkclient = ApiClient.shared.networkClient {

                    if !searchTypeButtonValue {
                        // Query search
                        self.doRegularSearch = PerformSearchUseCaseImp(dependencies: PerformSearchUseCaseImp.Dependencies(client: networkclient, searchText: textFieldInput))

                        self.doRegularSearch!.invoke().bind {
                            moviarray in
                            self.moviesSearch.accept(moviarray)
                        }.disposed(by: self.bag)

                    } else {
                        self.doKeywordSearch = PerformKeywordSearchUseCaseImp(dependencies: PerformKeywordSearchUseCaseImp.Dependencies(client: networkclient, searchText: textFieldInput))

                        self.doKeywordSearch!.invoke().bind { movieSect in
                            self.keywordSections.accept(movieSect)
                        }.disposed(by: self.bag)

                    }

                }

        }.disposed(by: bag)

    }
    
}
