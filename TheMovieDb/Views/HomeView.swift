//
//  HomeView.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 20/01/22.
//
import UIKit
import RxSwift
import RxCocoa

final class HomeView: UIViewController {
    
    let sectionsTableView = UITableView()
    
    private let bag = DisposeBag()
    private let homeViewModel: HomeViewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindUI()
        
    }
    
    private func setUI() {
        setTableView()
    }
    
    private func bindUI() {
        
        homeViewModel.sections
            .drive(sectionsTableView.rx.items(cellIdentifier: MovieSectionCell.identifier)) { [weak self] _, section, cell in
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
                                }).disposed(by: self.bag)
                            }
                        }.disposed(by: self.bag)
                    
                    movieSectionCell.moviesCollectionView.rx.modelSelected(MovieModel.self).throttle(.milliseconds(500), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] movie in
                        guard let self = self else { return }

                        let vc = MovieDetailView(movieModel: movie)
                        print(movie.title)
                        self.navigationController?.pushViewController(vc, animated: true)

                    }).disposed(by: self.bag)
                }
            }.disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
       AppUtility.lockOrientation(.portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)

       AppUtility.lockOrientation(.all)
   }
    
    private func setTableView() {

        view.addSubview(sectionsTableView)
        sectionsTableView.translatesAutoresizingMaskIntoConstraints = false
        sectionsTableView.separatorColor = .clear
        
        sectionsTableView.rowHeight = view.frame.size.width / 1.6
        sectionsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        sectionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sectionsTableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        sectionsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sectionsTableView.register(MovieSectionCell.self, forCellReuseIdentifier: MovieSectionCell.identifier)
        
    }
}
