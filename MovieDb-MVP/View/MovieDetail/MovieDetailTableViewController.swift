//
//  MovieDetailTableViewController.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 14/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {

    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    var movieTitle: String?
    var moviePosterURL: String = ""
    var movieDescription: String?
    var movieCategory: String?
    var movieRating: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var getImage = "https://image.tmdb.org/t/p/w500\(moviePosterURL)"
      
        let url = URL(string: getImage)!
        var data = try? Data(contentsOf: url)
        
        self.movieTitleLabel.text = self.movieTitle
        self.moviePosterImageView.image = UIImage(data: data!)
        self.movieCategoryLabel.text = self.movieCategory
        self.movieRatingLabel.text = self.movieRating
        self.movieDescriptionLabel.text = self.movieDescription

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    

}
