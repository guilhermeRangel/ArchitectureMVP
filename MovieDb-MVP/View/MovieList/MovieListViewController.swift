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
   
    
    var searchController = UISearchController(searchResultsController: SearchViewController())
    
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularMoviesTableView: UITableView!
    var idMovie = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection view delegate
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        popularMoviesTableView.delegate = self
        popularMoviesTableView.dataSource = self
        popularMoviesTableView.rowHeight = 150

        
        //Set navbar
        self.navigationController?.navigationItem.leftBarButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        //Setting up search controller
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Movie"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        
//        movie = MovieModel(movieName: "Jumanji", moviePoster: "jumanji", movieRating: "5.0")
//        movies = [movie, movie, movie] as? [MovieModel]
        
        movieListPresenter.popularMovies()
        movieListPresenter.moviesListDetails()
       
        // Do any additional setup after loading the view.
        
        
        
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailTableViewController{
            destination.movieTitle = movieListPresenter.movieListDetails?.results[idMovie].title
            destination.moviePosterURL = (movieListPresenter.movieListDetails?.results[idMovie].poster_path)!
            var id = movieListPresenter.movieListDetails?.results[idMovie].genre_ids?[0]
          
            movieListPresenter.moviesListDetails_ID(id: id!)
            var strGenres = ""
            for m in movieListPresenter.movieListDetails_ID!.genres! {
                strGenres = strGenres + m.name! + ","
                
            }
            destination.movieCategory = strGenres
            destination.movieRating = movieListPresenter.movieListDetails?.results[idMovie].vote_average?.description
            destination.movieDescription = movieListPresenter.movieListDetails?.results[idMovie].overview

        }
        if let destination = segue.destination as? SearchTableViewController{
            destination.query = ""
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
        idMovie = indexPath.row
       
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
        cell.setUpCell(movieTitle: String(movieListPresenter.movieList.moviesInList[indexPath.row].title!),
                       moviePosterURL: String(movieListPresenter.movieList.moviesInList[indexPath.row].poster_path!), movieRating: String(movieListPresenter.movieList.moviesInList[indexPath.row].vote_average!))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       idMovie = indexPath.row
        print(movieListPresenter.movieListDetails?.results[indexPath.row].title)
            performSegue(withIdentifier: "ToDetail", sender: movieListPresenter.movieListDetails?.results[indexPath.row])
            
        
        
      
        
    }
    
    
}

extension MovieListViewController: UISearchBarDelegate{
    
}

extension MovieListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        
        if searchController.searchBar.text?.count ?? 0 > 3{
            let search = searchController.searchBar.text ?? ""
            if let resultsController = searchController.searchResultsController as? SearchViewController{
                let searchPresenter = resultsController.searchPresenter
                searchPresenter.updateView(newQuery: search)
            }
        }
        
    }
    
    
}
