//
//  SearchView.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 20/01/22.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchView: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private var searchViewModel: SearchViewModel!
    
    // MARK: - UI Elements
    private let searchTxtField: UISearchTextField = {
       let textField = UISearchTextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(fromHex: AppConstants.Color.UnselectedFieldColor) ?? .opaqueSeparator
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = AppConstants.Search.searchPlaceHolderText
        textField.returnKeyType = .go
        textField.textColor = UIColor(fromHex: AppConstants.Color.fontNunitoBlueColor) ?? .label
        return textField
        
    }()
    
    private let searchResultTableView: UITableView = {
       let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        // tableV.separatorColor = .clear
        tableV.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableV.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        tableV.isHidden = false
        return tableV
    }()
    
    private let keywordResultTableView: UITableView = {
       let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.separatorColor = .clear
        tableV.register(MovieSectionCell.self, forCellReuseIdentifier: MovieSectionCell.identifier)
        tableV.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        tableV.isHidden = true
        return tableV
    }()
    
    private let headerSubView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(fromHex: AppConstants.Color.navBarColor) ?? UIColor.white
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let searchTypeBtn: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(fromHex: AppConstants.Color.UnselectedFieldColor) ?? .opaqueSeparator
        button.setTitleColor(UIColor(fromHex: AppConstants.Color.fontNunitoBlueColor) ?? .label, for: .normal)
        button.setTitle(AppConstants.Search.searchTypeText, for: .normal)
        button.layer.borderColor = UIColor(fromHex: AppConstants.Color.searchButtonBorder)?.cgColor ?? UIColor.yellow.cgColor
        
        button.layer.borderWidth = 0

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var searchTypeBtnValue: Bool = false
    
    // MARK: - Output
    private let textToSearch: PublishRelay<String> = PublishRelay()
    private let searchButtonStatusRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        
    // MARK: - METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.navigationItem.titleView = searchTxtField
        bindUI()
        self.hideKeyboardWhenTappedAround()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        searchViewModel = SearchViewModel(searchText: textToSearch, searchTypeStatus: searchButtonStatusRelay)
    }
    
    private func setUI() {
        searchResultTableView.rowHeight = view.frame.size.width / 3
        keywordResultTableView.rowHeight = view.frame.size.width / 1.6

        // searchResultTableView.backgroundColor = view.backgroundColor

//        view.addSubview(searchTxtField)
        view.addSubview(searchResultTableView)
        view.addSubview(keywordResultTableView)
        
        view.addSubview(headerSubView)
        headerSubView.addSubview(searchTxtField)
        headerSubView.addSubview(searchTypeBtn)
        searchTypeBtn.layer.cornerRadius = 5

        setConstraints()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setConstraints() {
        searchTxtField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        searchTxtField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        searchTxtField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        searchTxtField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        searchTypeBtn.topAnchor.constraint(equalTo: searchTxtField.bottomAnchor, constant: 10).isActive = true
        searchTypeBtn.leadingAnchor.constraint(equalTo: headerSubView.leadingAnchor, constant: 25).isActive = true
        searchTypeBtn.widthAnchor.constraint(equalToConstant: view.frame.size.width/3).isActive = true
        searchTypeBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        headerSubView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerSubView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        headerSubView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        headerSubView.heightAnchor.constraint(equalToConstant: view.frame.size.height/6).isActive = true

        searchResultTableView.topAnchor.constraint(equalTo: headerSubView.bottomAnchor).isActive = true
        searchResultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchResultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchResultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        keywordResultTableView.topAnchor.constraint(equalTo: headerSubView.bottomAnchor).isActive = true
        keywordResultTableView.leadingAnchor.constraint(equalTo: searchResultTableView.leadingAnchor).isActive = true
        keywordResultTableView.trailingAnchor.constraint(equalTo: searchResultTableView.trailingAnchor).isActive = true
        keywordResultTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

    }
    
    private func bindUI() {
        
//         Binding to textfield's Go key press.
        searchTxtField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            // emiting text writen by user so that ViewModel can perform Search
            self.textToSearch.accept(self.searchTxtField.text ?? "")

        }).disposed(by: disposeBag)

        searchTypeBtn.rx.tap.bind { [weak self] in
            guard let self = self else { return }

            self.searchTypeBtnValue.toggle()
            
            self.searchResultTableView.isHidden.toggle()
            self.keywordResultTableView.isHidden.toggle()
            self.searchButtonStatusRelay.accept( self.searchTypeBtnValue )
            
            if self.searchTypeBtnValue {
                self.searchTypeBtn.backgroundColor = UIColor(fromHex: AppConstants.Color.searchButtonSelectedColor) ?? .systemYellow
                self.searchTypeBtn.layer.borderWidth = 2
            } else {
                self.searchTypeBtn.backgroundColor = UIColor(fromHex: AppConstants.Color.UnselectedFieldColor) ?? .opaqueSeparator
                self.searchTypeBtn.layer.borderWidth = 0
                
            }
            
        }.disposed(by: disposeBag)
        
        searchViewModel.keywordSections
                .observeOn(MainScheduler.instance)
                .bind(to: keywordResultTableView.rx.items(cellIdentifier: MovieSectionCell.identifier)) { [weak self] _, section, cell in
                    guard let self = self else { return }
                    if let movieSectionCell = cell as? MovieSectionCell {
                        movieSectionCell.sectionTitleLbl.text = section.sectionTitle
                        
                        // Reseting datasource / delegate to prevent crash by re assigning delegate and datasource
                        movieSectionCell.moviesCollectionView.delegate = nil
                        movieSectionCell.moviesCollectionView.dataSource = nil
                        
                        section.Movies
                            .drive(movieSectionCell.moviesCollectionView.rx.items(cellIdentifier: MovieItemCollectionViewCell.identifier)) { [weak self] _, movie, movieCell in
                                guard let self = self else { return }
                                if let movieItemCell = movieCell as? MovieItemCollectionViewCell {
                                    movieItemCell.movieTitleLbl.text = movie.title
                                    // subscribe to movies img fetcher
                                    movie.posterImg.drive( onNext: { img in
                                        movieItemCell.moviePosterImgView.image = img
                                    }).disposed(by: self.disposeBag)
                                }
                            }.disposed(by: self.disposeBag)
                        
                        movieSectionCell.moviesCollectionView.rx.modelSelected(MovieModel.self).throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] movie in
                            guard let self = self else { return }

                            let vc = MovieDetailView(movieModel: movie)
                            print(movie.title)
                            self.navigationController?.pushViewController(vc, animated: true)

                        }).disposed(by: self.disposeBag)
                        
                    }
                }.disposed(by: disposeBag)
        
        searchViewModel.moviesSearch
            .observeOn(MainScheduler.instance)
            .bind(to: searchResultTableView.rx.items(cellIdentifier: SearchResultCell.identifier)) { [weak self] _, movie, cell in
                guard let self = self else { return }

                if let searchResultCell = cell as? SearchResultCell {
                    
                    searchResultCell.movieTitleLbl.text = movie.title
                    searchResultCell.movieDetailLbl.text = movie.releaseDate?.components(separatedBy: "-")[0]
                    searchResultCell.movieExtraInfoLbl.text = movie.overview
                    
                    movie.posterImg.drive( onNext: { img in
                        searchResultCell.moviePosterImgView.image = img
                    }).disposed(by: self.disposeBag)
                
                }
 
            }.disposed(by: disposeBag)
        
        searchResultTableView.rx.modelSelected(MovieModel.self).throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] movie in
            guard let self = self else { return }

            let vc = MovieDetailView(movieModel: movie)
            print(movie.title)
            self.navigationController?.pushViewController(vc, animated: true)

        }).disposed(by: disposeBag)
        
    }
    
}
