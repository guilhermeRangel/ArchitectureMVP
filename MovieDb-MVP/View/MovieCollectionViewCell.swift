//
//  MovieCollectionViewCell.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 19/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    
    var moviePosterURL: String = ""
    var movieTitle: String = ""
    var movieRating: String = ""

    
    func setUpCell(movieTitle: String, moviePosterURL: String, movieRating: String){
        self.moviePosterImage.image = UIImage(named: moviePosterURL)
        self.movieTitleLabel.text = movieTitle
        self.movieRatingLabel.text = movieRating
    }
    
}
