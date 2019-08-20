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
            destination.movieDescription = ""
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
        return (movieListPresenter.movieListDetails?.results.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesCell", for: indexPath) as? PopularMoviesTableViewCell else {
            fatalError()
        }
     

        
        cell.setupCell(movieTitle: String((movieListPresenter.movieListDetails?.results[indexPath.row].title)!), moviePosterURL: String((movieListPresenter.movieListDetails?.results[indexPath.row].poster_path)!), movieRating: String((movieListPresenter.movieListDetails?.results[indexPath.row].vote_average)!), movieDescription: String((movieListPresenter.movieListDetails?.results[indexPath.row].overview)!))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
        
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell
            else {
                fatalError()
        }
        
       // cell.setUpCell(movieTitle: movie!.movieName , moviePosterURL: movie!.moviePoster , movieRating: movie!.movieRating)
        
        cell.setUpCell(movieTitle: String(movieListPresenter.movieList.moviesInList[indexPath.row].title!),
                       moviePosterURL: String(movieListPresenter.movieList.moviesInList[indexPath.row].poster_path!), movieRating: String(movieListPresenter.movieList.moviesInList[indexPath.row].vote_average!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    
}

extension MovieListViewController: UISearchBarDelegate{
    
}
