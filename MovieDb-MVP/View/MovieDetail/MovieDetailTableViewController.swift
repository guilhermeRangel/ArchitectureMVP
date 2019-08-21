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
    
    var movieId: Int?
    var moviePresenter:MoviePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviePresenter?.getMovie(id: self.movieId!)
        
        let movie = moviePresenter?.movieListDetails_ID
      
        let getImage = "https://image.tmdb.org/t/p/w500\(movie?.poster_path ?? "")"
        let url = URL(string: getImage)!
        let data = try? Data(contentsOf: url)
        
        self.movieTitleLabel.text = movie?.title
        self.moviePosterImageView.image = UIImage(data: data!)
        self.movieCategoryLabel.text = setCategories()
        self.movieRatingLabel.text = "\(movie?.vote_average ?? 0)"
        self.movieDescriptionLabel.text = movie?.overview

    }
    
    func setCategories()->String{
        var strGenres = ""
        for m in (moviePresenter?.movieListDetails_ID!.genres!)! {
            strGenres = strGenres + m.name! + ","
        }
        return strGenres
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
