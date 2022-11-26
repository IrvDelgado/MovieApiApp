//
//  MovieSectionCell.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 24/01/22.
//

import UIKit

final class MovieSectionCell: UITableViewCell {
    static let identifier = "MovieSectionCell"

    let sectionTitleLbl = UILabel()
    let colorSectionLbl: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(fromHex: AppConstants.Color.navBarColor) ?? UIColor.white
        
        label.layer.masksToBounds = true
        return label
    }()
    var moviesCollectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        setTitleLabel()
        setMoviesCollectionView()
    }

    private func setTitleLabel() {

        sectionTitleLbl.numberOfLines = 0
        sectionTitleLbl.lineBreakMode = NSLineBreakMode.byWordWrapping
        // NiceToHave: - Add nunito sans font
        sectionTitleLbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        contentView.addSubview(sectionTitleLbl)

        contentView.addSubview(colorSectionLbl)
    }
    
    private func setMoviesCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 0)
        moviesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        moviesCollectionView.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
   
        layout.itemSize = CGSize(width: contentView.frame.width/3, height: contentView.frame.width/2)

         contentView.addSubview(moviesCollectionView)

        moviesCollectionView.register(MovieItemCollectionViewCell.self, forCellWithReuseIdentifier: MovieItemCollectionViewCell.identifier)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
        sectionTitleLbl.frame = CGRect(x: 28, y: 15, width: 0, height: 0)
        sectionTitleLbl.sizeToFit()
        sectionTitleLbl.frame.size = sectionTitleLbl.bounds.size

        colorSectionLbl.frame = CGRect(x: 15, y: 15, width: 6, height: sectionTitleLbl.frame.height)
        
        moviesCollectionView.frame = CGRect(x: 15, y: sectionTitleLbl.frame.maxY+5, width: contentView.frame.size.width-30, height: ( contentView.frame.size.height )-(sectionTitleLbl.frame.maxY+5))
    }
    
}
