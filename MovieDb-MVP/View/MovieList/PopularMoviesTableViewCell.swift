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
        
        let getImage = "https://image.tmdb.org/t/p/w500\(moviePosterURL)"
        let url = URL(string: getImage)!
        let data = try? Data(contentsOf: url)
        
        self.movieTitleLabel.text = movieTitle
        self.moviePosterImage.image = UIImage(data: data!)
        self.movieRatingLabel.text = movieRating
        self.movieDescriptionLabel.text = movieDescription
    }

}
