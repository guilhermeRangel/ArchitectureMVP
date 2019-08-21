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
    
    var popularMovies: [MovieDetail]?
    var nowPlayingMovies: MovieList?
    
    @IBOutlet weak var filteredMoviesCollectionView: UICollectionView!
    @IBOutlet weak var nowPlayingCollectionView: UICollectionView!
    @IBOutlet weak var popularMoviesTableView: UITableView!
    var idMovie = 0
    // 0 now, 1 popular
    //var observerClickSegue = 99
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.popularMovies = []
        enum Section {
            case nowPlaying, popular
        }
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        filteredMoviesCollectionView.delegate = self
        filteredMoviesCollectionView.dataSource = self
        
        //Table view delegate
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
        
        //Setting up presenter
        movieListPresenter.attachView(self)
        movieListPresenter.getNowPlaying()
        movieListPresenter.getPopularMovies()
       
        // Do any additional setup after loading the view.
        
        
        
    }
    
    
    @IBAction func seeAllMovies(_ sender: Any) {
        performSegue(withIdentifier: "ToAll", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailTableViewController{
          destination.movieId = idMovie
            destination.moviePresenter = self.movieListPresenter
        }
        if let destination = segue.destination as? SearchTableViewController{
            destination.query = ""
        }
        if let destination = segue.destination as? SeeAllCollectionViewController{
            destination.movieList = self.movieListPresenter.nowPlayingMovies.moviesInList
        }
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.popularMovies?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PopularMoviesCell", for: indexPath) as? PopularMoviesTableViewCell else {
            fatalError()
        }

        let movie = popularMovies![indexPath.row]
        cell.setupCell(movieTitle: movie.title!, moviePosterURL: movie.poster_path!, movieRating: "\(movie.vote_average)", movieDescription: movie.overview!)
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.nowPlayingCollectionView{
            return 5
        } else {
            return movieListPresenter.filteredMovies.moviesInList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var movieList = self.movieListPresenter.nowPlayingMovies.moviesInList
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       idMovie = nowPlayingMovies?.moviesInList[indexPath.row].id ?? 0
        print(nowPlayingMovies?.moviesInList[indexPath.row].title)
            performSegue(withIdentifier: "ToDetail", sender: movieListPresenter.popularMovieList?.results[indexPath.row])
        
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

extension MovieListViewController: MovieListView{
    func updatePopularMovies(movies: [MovieDetail]) {
        self.popularMovies = movies
        self.popularMoviesTableView.reloadData()
    }
    
    func updateNowPlaying(movies: MovieList) {
        self.nowPlayingMovies = movies
        self.nowPlayingCollectionView.reloadData()
    }
    
    
}
