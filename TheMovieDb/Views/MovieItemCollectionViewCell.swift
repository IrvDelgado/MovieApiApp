//
//  MovieItemCollectionViewCell.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 25/01/22.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieItemCollectionViewCell"
    var cellSafeArea: UILayoutGuide!
    
    let movieTitleLbl: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.borderColor = UIColor.separator.cgColor
        label.layer.borderWidth = 0.5
        return label
    }()
    
    let moviePosterImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true

        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        cellSafeArea = layoutMarginsGuide
        contentView.addSubview(movieTitleLbl)
        contentView.addSubview(moviePosterImgView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        moviePosterImgView.frame = CGRect(x: 5, y: contentView.frame.minY, width: contentView.frame.width-10, height: contentView.frame.height-(contentView.frame.minY)-37)
        
        movieTitleLbl.frame = CGRect(x: 5, y: moviePosterImgView.frame.maxY-4, width: moviePosterImgView.frame.width, height: 43)
         movieTitleLbl.frame.size = movieTitleLbl.bounds.size
        
        movieTitleLbl.layer.cornerRadius = movieTitleLbl.frame.width/14
    }

}
