//
//  ViewController.swift
//  MovieDb-MVP
//
//  Created by Guilherme Rangel on 14/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

class MoviePresenter {

   
    var movieList = MovieList.init(movies: [])
    var seeAllMovieList = MovieList.init(movies: [])
    var movieListOrderByVoteAverage = MovieList.init(movies: [])
    var movieListDetails : headerDetails?
    var movies = MoviesService()
    var movieListDetails_ID : MovieDetail_ID?
    var filteredMovies = MovieList.init(movies: [])
    
    func popularMovies(){
        movieListOrderByVoteAverage = movies.getPopularMovies()
        movieList.moviesInList = movieListOrderByVoteAverage.moviesInList.sorted { (a, b) -> Bool in
            return a.vote_average! > b.vote_average!
        }
    }
    func seeAllMovies(_ page: Int) {
//        print(movieList.moviesInList.count)
//        print(movies.getSeeAllByPage(page).moviesInList.count)
        self.movieList.moviesInList += movies.getSeeAllByPage(page).moviesInList
        print(movieList.moviesInList.count)
//        movieList.moviesInList += seeAllMovieList.moviesInList
    }
    
    func moviesListDetails(){
         self.movieListDetails = movies.getMovieDetails()
    }
    func moviesListDetails_ID(id : Int){
        let idMovie = id
        self.movieListDetails_ID = movies.getMovieDetails_ID(id: idMovie)
    }
    func searchMovie(title search: String){
        self.filteredMovies.moviesInList = self.movieList.moviesInList.filter(({(movie:Movie) -> Bool in
            return movie.title?.lowercased().contains(search.lowercased()) ?? false
        }))
    }
}

