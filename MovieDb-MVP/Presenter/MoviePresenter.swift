//
//  ViewController.swift
//  MovieDb-MVP
//
//  Created by Guilherme Rangel on 14/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

class MoviePresenter {

    //lista vizia
    var movieList = MovieList.init(movies: [])
    var movieListDetails : MovieDetail?
    var movies = MoviesService()
    
    
    func popularMovies(){
        
        movieList = movies.getPopularMovies() // roda as requisicao da api
        print(movieList.moviesInList.count)
    }
    
    func moviesListDetails(){
         self.movieListDetails = movies.getMovieDetails()
        print(movieListDetails.debugDescription)
    }
    
    

}

