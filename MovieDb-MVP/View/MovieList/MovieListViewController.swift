//
//  MovieListViewController.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 20/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    var movieListPresenter = MoviePresenter()
    var movie: MovieModel?
    var movies: [MovieModel]?
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularMoviesTableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        //Collection view delegate
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        popularMoviesTableView.delegate = self
        popularMoviesTableView.dataSource = self
        popularMoviesTableView.rowHeight = 150
    
        
        movie = MovieModel(movieName: "Jumanji", moviePoster: "jumanji", movieRating: "5.0")
        movies = [movie, movie, movie] as? [MovieModel]
        
        movieListPresenter.popularMovies()
        movieListPresenter.moviesListDetails()
        movieListPresenter.moviesListDetails_ID(id: 429203)
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailTableViewController{
            destination.movieTitle = movie?.movieName
            destination.moviePosterURL = movie?.moviePoster
            destination.movieCategory = "Aventura"
            destination.movieRating = movie?.movieRating
            destination.movieDescription = """
            Jumanji is a 1995 American fantasy adventure film directed by Joe Johnston. It is an adaptation of the 1981 children's book of the same name by Chris Van Allsburg and the first installment of the Jumanji franchise. The film was written by Van Allsburg, Greg Taylor, Jonathan Hensleigh, and Jim Strain and stars Robin Williams, Bonnie Hunt, Kirsten Dunst, Bradley Pierce, Jonathan Hyde, Bebe Neuwirth, and David Alan Grier.
            
            The story centers on a supernatural board game that releases jungle-based hazards upon its players with every turn they take. As a boy in 1969, Alan Parrish became trapped inside the game itself while playing with his best friend Sarah Whittle. Twenty-six years later, in 1995, siblings Judy and Peter Shepherd find the game, begin playing and then unwittingly release the now-adult Alan. After tracking down Sarah, the quartet resolve to finish the game in order to reverse all of the destruction it has caused.
            
            The film was released on December 15, 1995 and grossed $263 million worldwide on a budget of approximately $65 million and it became the 10th highest-grossing film of 1995. Despite the box office success, the film received generally mixed reviews from critics. Critics praised Robin Williams' performance, and the film's visual effects.
            """
        }
        if let destination = segue.destination as? SearchTableViewController{
            destination.query = searchBar.text ?? ""
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesCell", for: indexPath) as? PopularMoviesTableViewCell else {
            fatalError()
        }
        cell.setupCell(movieTitle: movie!.movieName, moviePosterURL: movie!.moviePoster, movieRating: movie!.movieRating, movieDescription: "A movie")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell
            else {
                fatalError()
        }
        
        cell.setUpCell(movieTitle: movie!.movieName , moviePosterURL: movie!.moviePoster , movieRating: movie!.movieRating)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    
}

extension MovieListViewController: UISearchBarDelegate{
    
}
