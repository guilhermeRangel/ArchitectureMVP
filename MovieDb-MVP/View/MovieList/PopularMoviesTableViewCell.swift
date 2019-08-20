//
//  PopularMoviesTableViewCell.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 20/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePosterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func setupCell(movieTitle: String, moviePosterURL: String, movieRating: String, movieDescription: String){
        self.movieTitleLabel.text = movieTitle
        self.moviePosterImage.image = UIImage(named: moviePosterURL)
        self.movieRatingLabel.text = movieRating
        self.movieDescriptionLabel.text = movieDescription
    }

}
