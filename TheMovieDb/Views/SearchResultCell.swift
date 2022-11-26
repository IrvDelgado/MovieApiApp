//
//  SearchResultCell.swift
//  TheMovieDb
//
//  Created by Irving Delgado Silva on 30/01/22.
//

import UIKit

class SearchResultCell: UITableViewCell {

    static let identifier = "SearchResultCell"

    let moviePosterImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.masksToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
         imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
    let movieTitleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let movieDetailLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let movieExtraInfoLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         contentView.backgroundColor = UIColor(fromHex: AppConstants.Color.backgroundColor) ?? UIColor.white
        setupView()
    }
    
    private func setupView() {
        contentView.addSubview(moviePosterImgView)
        contentView.addSubview(movieTitleLbl)
        contentView.addSubview(movieDetailLbl)
        contentView.addSubview(movieExtraInfoLbl)
        
        moviePosterImgView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        moviePosterImgView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        // moviePosterImgView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor).isActive = true
//        moviePosterImgView.widthAnchor.constraint(equalToConstant: contentView.frame.size.width/4).isActive = true
        moviePosterImgView.widthAnchor.constraint(equalTo: moviePosterImgView.heightAnchor, multiplier: 1.0/1.6).isActive = true

        moviePosterImgView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true

        movieTitleLbl.topAnchor.constraint(equalTo: moviePosterImgView.topAnchor).isActive = true
        movieTitleLbl.leadingAnchor.constraint(equalTo: moviePosterImgView.trailingAnchor, constant: 10).isActive = true
        movieTitleLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        movieTitleLbl.widthAnchor.constraint(equalToConstant: ((contentView.frame.size.width/4)*3.3) ).isActive = true

        movieDetailLbl.topAnchor.constraint(equalTo: movieTitleLbl.bottomAnchor, constant: 5).isActive = true
        movieDetailLbl.leadingAnchor.constraint(equalTo: movieTitleLbl.leadingAnchor).isActive = true
        movieDetailLbl.heightAnchor.constraint(greaterThanOrEqualToConstant: 0).isActive = true
        movieDetailLbl.trailingAnchor.constraint(equalTo: movieTitleLbl.trailingAnchor).isActive = true
    
        movieExtraInfoLbl.topAnchor.constraint(equalTo: movieDetailLbl.bottomAnchor, constant: 5).isActive = true
        movieExtraInfoLbl.leadingAnchor.constraint(equalTo: movieTitleLbl.leadingAnchor).isActive = true
        movieExtraInfoLbl.trailingAnchor.constraint(equalTo: movieTitleLbl.trailingAnchor).isActive = true
        movieExtraInfoLbl.bottomAnchor.constraint(equalTo: moviePosterImgView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// 1/7
