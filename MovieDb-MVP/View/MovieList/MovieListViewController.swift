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
   
    
    var searchController = UISearchController(searchResultsController:nil)
    
    @IBOutlet weak var filteredMoviesCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularMoviesTableView: UITableView!
    var idMovie = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Collection view delegate
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        filteredMoviesCollectionView.delegate = self
        filteredMoviesCollectionView.dataSource = self
        
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

        movieListPresenter.popularMovies()
        movieListPresenter.moviesListDetails()
 
        
    }
    
    
    @IBAction func seeAllMovies(_ sender: Any) {
        performSegue(withIdentifier: "ToAll", sender: self)
    }
    

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
        if let destination = segue.destination as? SeeAllCollectionViewController{
            destination.movieList = self.movieListPresenter.movieList.moviesInList
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        idMovie = indexPath.row
        performSegue(withIdentifier: "ToDetail", sender: movieListPresenter.movieListDetails?.results[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.nowPlayingCollectionView{
            return 5
        } else {
            return movieListPresenter.filteredMovies.moviesInList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var movieList = self.movieListPresenter.movieList.moviesInList
        if collectionView == self.filteredMoviesCollectionView{
            movieList = self.movieListPresenter.filteredMovies.moviesInList
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell
            else {
                fatalError()
        }
        cell.setUpCell(movieTitle: String(movieList[indexPath.row].title!),
                       moviePosterURL: String(movieList[indexPath.row].poster_path!), movieRating: String(movieList[indexPath.row].vote_average!))
        return cell
    }
    
    
}

extension MovieListViewController: UISearchBarDelegate{
    
}

extension MovieListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {

        if searchController.searchBar.text?.count ?? 0 > 3{
            movieListPresenter.searchMovie(title: searchController.searchBar.text ?? "")
            filteredMoviesCollectionView.reloadData()
            self.filteredMoviesCollectionView.isHidden = false
        } else {
            self.filteredMoviesCollectionView.isHidden = true
        }
        
    }
    
    
}
