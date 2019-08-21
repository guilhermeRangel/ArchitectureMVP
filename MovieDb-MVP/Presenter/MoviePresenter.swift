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
    var movieListOrderByVoteAverage = MovieList.init(movies: [])
    var movieListDetails : headerDetails?
    var movies = MoviesService()
    var movieListDetails_ID : MovieDetail_ID?
    var filteredMovies = MovieList.init(movies: [])
    var maior = 0.0
    
    func popularMovies(){
        movieListOrderByVoteAverage = movies.getPopularMovies() // roda as requisicao da api
        movieList.moviesInList = movieListOrderByVoteAverage.moviesInList.sorted { (a, b) -> Bool in
            return a.vote_average! > b.vote_average!
        }
        
       
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
        print(self.filteredMovies.moviesInList)
    }
    
}

