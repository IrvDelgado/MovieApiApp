//
//  MovieDetailView.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 01/02/22.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

final class MovieDetailView: UIViewController {

    private let disposeBag = DisposeBag()
    private let movieDetailViewModel: MovieDetailViewModel
    
    // MARK: UI ELEMENTS

    private let backBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = UIColor(fromHex: AppConstants.Color.navBarColor) ?? UIColor.clear
        return button
    }()
    
    private let reviewsBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Reviews", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 11.5, weight: .regular)
//        button.setTitleColor(.link, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.layer.borderColor = UIColor(fromHex: AppConstants.Color.navBarColorClear)?.cgColor ?? UIColor.clear.cgColor
      
//        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(fromHex: AppConstants.Color.navBarColorClear)
        return button
    }()
    
    private let movieInformationSubView: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let backdropImgView: UIImageView = {
       let imgV = UIImageView()
        imgV.translatesAutoresizingMaskIntoConstraints = false
        imgV.image = UIImage(systemName: "iphone")
        imgV.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        return imgV
    }()
    
    let moviePosterImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
//        imgView.image = UIImage(systemName: "pencil.tip")
        imgView.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white

        return imgView
    }()
    
    let movieTitleLbl: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .orange
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .left
        label.layer.masksToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a movie Title"
        
        return label
    }()
    
    let yearLbl: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .brown
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .left
        label.layer.masksToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "YEAR"

        return label
    }()
    
    let runTimeLbl: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .cyan
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .left
        label.layer.masksToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Runtime "

        return label
    }()
    
    let tagLineLbl: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .systemTeal
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .left
        label.layer.masksToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tagline..."

        return label
    }()
    
    let overViewLbl: UITextView = {
        let label = UITextView()
        label.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textAlignment = .justified
        label.layer.masksToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a movie description ..."
        label.isEditable = false
        
        return label
    }()
    
    private let otherMoviesTableView: UITableView = {
       let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        tableV.separatorColor = .clear
        tableV.register(MovieSectionCell.self, forCellReuseIdentifier: MovieSectionCell.identifier)
        tableV.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        return tableV
    }()
    
    private let castTableView: UITableView = {
       let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        // tableV.separatorColor = .clear
        tableV.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableV.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        tableV.isHidden = false
        return tableV
    }()
    
    private let crewTableView: UITableView = {
       let tableV = UITableView()
        tableV.translatesAutoresizingMaskIntoConstraints = false
        // tableV.separatorColor = .clear
        tableV.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.identifier)
        tableV.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        tableV.isHidden = true
        return tableV
    }()
    
    private let creditsSegmentedControl: UISegmentedControl = {
        let customSC = UISegmentedControl(items: AppConstants.segmentedControlItems)
        customSC.selectedSegmentIndex = 0
        customSC.translatesAutoresizingMaskIntoConstraints = false
        return customSC
    }()
    
    // MARK: METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindUI()
    }
    
    override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
    }
    
    /// Creates an instance of MovieDetailView
    init(movieModel: MovieModel) {
        self.movieDetailViewModel = MovieDetailViewModel(movie: movieModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    private func setUI() {
        view.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        
        movieInformationSubView.addSubview(backdropImgView)
        movieInformationSubView.addSubview(movieTitleLbl)
        movieInformationSubView.addSubview(yearLbl)
        movieInformationSubView.addSubview(runTimeLbl)
        movieInformationSubView.addSubview(overViewLbl)
        movieInformationSubView.addSubview(tagLineLbl)
        movieInformationSubView.addSubview(moviePosterImgView)
        
        view.addSubview(movieInformationSubView)
        otherMoviesTableView.rowHeight = view.frame.size.width / 1.6
        
        castTableView.rowHeight = view.frame.size.width / 4.8
        crewTableView.rowHeight = view.frame.size.width / 4.8
        
        view.addSubview(movieInformationSubView)
        view.addSubview(otherMoviesTableView)
        view.addSubview(castTableView)
        view.addSubview(crewTableView)
        view.addSubview(creditsSegmentedControl)
        view.addSubview(backBtn)
        view.addSubview(reviewsBtn)

        setConstraints()

    }

    private func setConstraints() {
        
        backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backBtn.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        reviewsBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        reviewsBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        reviewsBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        reviewsBtn.widthAnchor.constraint(equalToConstant: 67).isActive = true
        reviewsBtn.layer.cornerRadius = 13

        movieInformationSubView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieInformationSubView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        movieInformationSubView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        movieInformationSubView.heightAnchor.constraint(equalToConstant: view.frame.size.height/2).isActive = true

        backdropImgView.topAnchor.constraint(equalTo: movieInformationSubView.topAnchor).isActive = true
        backdropImgView.leadingAnchor.constraint(equalTo: movieInformationSubView.leadingAnchor).isActive = true
        backdropImgView.trailingAnchor.constraint(equalTo: movieInformationSubView.trailingAnchor).isActive = true
        backdropImgView.heightAnchor.constraint(equalToConstant: view.frame.size.height/3.4).isActive = true
        
        moviePosterImgView.topAnchor.constraint(equalTo: backdropImgView.bottomAnchor, constant: -20).isActive = true
        moviePosterImgView.trailingAnchor.constraint(equalTo: movieInformationSubView.trailingAnchor, constant: -15).isActive = true
        moviePosterImgView.heightAnchor.constraint(equalToConstant: view.frame.size.height/6).isActive = true
        moviePosterImgView.widthAnchor.constraint(equalToConstant: view.frame.size.width/4.2).isActive = true

        movieTitleLbl.topAnchor.constraint(equalTo: backdropImgView.bottomAnchor, constant: 10).isActive = true
        movieTitleLbl.leadingAnchor.constraint(equalTo: movieInformationSubView.leadingAnchor, constant: 15).isActive = true
        movieTitleLbl.trailingAnchor.constraint(equalTo: moviePosterImgView.leadingAnchor, constant: -5).isActive = true
        movieTitleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true

        yearLbl.topAnchor.constraint(equalTo: movieTitleLbl.bottomAnchor, constant: 5).isActive = true
        yearLbl.leadingAnchor.constraint(equalTo: movieTitleLbl.leadingAnchor, constant: 5).isActive = true
        yearLbl.trailingAnchor.constraint(equalTo: movieTitleLbl.trailingAnchor).isActive = true
        yearLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true

        runTimeLbl.topAnchor.constraint(equalTo: yearLbl.bottomAnchor).isActive = true
        runTimeLbl.leadingAnchor.constraint(equalTo: yearLbl.leadingAnchor).isActive = true
        runTimeLbl.trailingAnchor.constraint(equalTo: yearLbl.trailingAnchor).isActive = true
        runTimeLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true

        tagLineLbl.topAnchor.constraint(equalTo: runTimeLbl.bottomAnchor, constant: 5).isActive = true
        tagLineLbl.leadingAnchor.constraint(equalTo: runTimeLbl.leadingAnchor).isActive = true
        tagLineLbl.trailingAnchor.constraint(equalTo: moviePosterImgView.leadingAnchor).isActive = true
        tagLineLbl.heightAnchor.constraint(equalToConstant: 25).isActive = true

        overViewLbl.topAnchor.constraint(equalTo: moviePosterImgView.bottomAnchor, constant: 5).isActive = true
        overViewLbl.leadingAnchor.constraint(equalTo: tagLineLbl.leadingAnchor).isActive = true
        overViewLbl.trailingAnchor.constraint(equalTo: moviePosterImgView.trailingAnchor).isActive = true
        overViewLbl.bottomAnchor.constraint(equalTo: movieInformationSubView.bottomAnchor, constant: -5).isActive = true
        
        creditsSegmentedControl.topAnchor.constraint(equalTo: movieInformationSubView.bottomAnchor, constant: 5).isActive = true
        creditsSegmentedControl.leadingAnchor.constraint(equalTo: movieInformationSubView.leadingAnchor, constant: 15).isActive = true
        creditsSegmentedControl.trailingAnchor.constraint(equalTo: movieInformationSubView.trailingAnchor, constant: -15).isActive = true
        creditsSegmentedControl.heightAnchor.constraint(equalToConstant: view.frame.size.width/15).isActive = true
        
        castTableView.topAnchor.constraint(equalTo: creditsSegmentedControl.bottomAnchor).isActive = true
        castTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        castTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        castTableView.heightAnchor.constraint(equalToConstant: view.frame.size.height/6).isActive = true
        
        crewTableView.topAnchor.constraint(equalTo: creditsSegmentedControl.bottomAnchor).isActive = true
        crewTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        crewTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        crewTableView.heightAnchor.constraint(equalToConstant: view.frame.size.height/6).isActive = true
        
        otherMoviesTableView.topAnchor.constraint(equalTo: castTableView.bottomAnchor).isActive = true
        otherMoviesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        otherMoviesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        otherMoviesTableView.heightAnchor.constraint(equalToConstant: view.frame.size.height/3).isActive = true
    }
    private func bindUI() {
        
        backBtn.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).bind {
            // TODO: -  add gesture to back behavior
            self.navigationController?.popViewController(animated: true)

        }.disposed(by: disposeBag)
        
        reviewsBtn.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).bind {
            
            if !self.movieDetailViewModel.reviewsArray.isEmpty {
                
                let reviewsViewHostingController = UIHostingController(rootView: ReviewsView(reviewsArray: self.movieDetailViewModel.reviewsArray))

                self.navigationController?.pushViewController(reviewsViewHostingController, animated: true)
            } else {
                let alert = UIAlertController(title: "No reviews", message: "There are no reviews yet", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)
            }
            
        }.disposed(by: disposeBag)
        
        creditsSegmentedControl.rx.controlEvent(.valueChanged).bind { [weak self] _ in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.castTableView.isHidden.toggle()
                self.crewTableView.isHidden.toggle()
            }
        }.disposed(by: disposeBag)
        
        bindMovieDetails()
        bindCredits()
        bindMovieReviews()
        bindOtherMovies()
    }
    
    private func bindMovieDetails() {
        movieDetailViewModel.movieInfo?
            .observeOn(MainScheduler.instance)
            .bind { [weak self] moviemodel in
                guard let self = self else {return}
                self.movieTitleLbl.text = moviemodel.title
                
                self.yearLbl.text = "(" + (moviemodel.releaseDate?.components(separatedBy: "-")[0] ?? "") + ")"
                self.overViewLbl.text = moviemodel.overview
                
                moviemodel.movieDetails?
                    .observeOn(MainScheduler.instance)
                    .bind { [weak self] moviedetails in
                    
                        guard let self = self else {return}
              
                        self.tagLineLbl.text = moviedetails.tagline
                        self.runTimeLbl.text = String(moviedetails.runtime ?? 0) + " min."
      
                }.disposed(by: self.disposeBag)
                
                moviemodel.posterImg.drive( onNext: { [weak self]  img in
                    guard let self = self else {return}

                    self.moviePosterImgView.image = img
                }).disposed(by: self.disposeBag)
                
                moviemodel.backdropImg.drive( onNext: { [weak self]  img in
                    guard let self = self else {return}

                    self.backdropImgView.image = img
                }).disposed(by: self.disposeBag)
                
            }.disposed(by: disposeBag)
    }
    
    private func bindCredits() {
        // Binding movie credits: cast & crew
        
        movieDetailViewModel.movieCredits?.observeOn(MainScheduler.instance)
            .bind { [weak self] movieCredits in
                guard let self = self else {return}

                // Cast
                movieCredits.cast
                    .drive(self.castTableView.rx.items(cellIdentifier: SearchResultCell.identifier)) { [weak self] _, creditPerson, cell in
                        guard let self = self else { return }
                        if let searchResultCell = cell as? SearchResultCell, let castPerson = creditPerson as? CastPerson {
                            searchResultCell.movieTitleLbl.text = castPerson.name
                            searchResultCell.movieDetailLbl.text = castPerson.character
//                            searchResultCell.movieExtraInfoLbl.text = castPerson.knownDepartment
                            
                            castPerson.profilePath?.drive( onNext: { img in
                                searchResultCell.moviePosterImgView.image = img
                            }).disposed(by: self.disposeBag)
                        }
                    }.disposed(by: self.disposeBag)
                
                // Crew
                movieCredits.crew
                    .drive(self.crewTableView.rx.items(cellIdentifier: SearchResultCell.identifier)) { [weak self] _, creditPerson, cell in
                        guard let self = self else { return }
                        if let searchResultCell = cell as? SearchResultCell, let crewPerson = creditPerson as? CrewPerson {
                            searchResultCell.movieTitleLbl.text = crewPerson.name
                            searchResultCell.movieDetailLbl.text = crewPerson.job
                            searchResultCell.movieExtraInfoLbl.text = crewPerson.knownDepartment
                            
                            crewPerson.profilePath?.drive( onNext: { img in
                                searchResultCell.moviePosterImgView.image = img
                            }).disposed(by: self.disposeBag)
                        }
                    }.disposed(by: self.disposeBag)
                
            }.disposed(by: disposeBag)
        
    }
    
    private func bindMovieReviews() {
        // Binding movie reviews
        movieDetailViewModel.movieReviews?.observeOn(MainScheduler.instance)
            .bind {[weak self] reviewsArray in
                guard let self = self else {return}
                                
                self.movieDetailViewModel.reviewsArray = reviewsArray
                
            }.disposed(by: disposeBag)
    }
    
    private func bindOtherMovies() {
        // Binding other movies: similar & recommended movies Table
        movieDetailViewModel.otherMoviesSection?
            .observeOn(MainScheduler.instance)
            .bind(to: otherMoviesTableView.rx.items(cellIdentifier: MovieSectionCell.identifier)) { [weak self] _, section, cell in
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
                        self.navigationController?.pushViewController(vc, animated: true)

                    }).disposed(by: self.disposeBag)
                }
            }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(movieModel: MovieModel(
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
            movieDetails: nil)
        )
    }
    
}
