//
//  ViewController.swift
//  MovieDb-MVP
//
//  Created by Guilherme Rangel on 14/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

class MoviePresenter {

   
    var nowPlayingMovies = MovieList.init(movies: [])
    var movieListOrderByVoteAverage = MovieList.init(movies: [])
    var popularMovieList : headerDetails?
    var movies = MoviesService()
    var movieListDetails_ID : MovieDetail_ID?
    var filteredMovies = MovieList.init(movies: [])
    var movieView: MovieListView?
    
    func attachView(_ view: MovieListView){
        self.movieView = view
    }
    
    func getNowPlaying(){
        nowPlayingMovies = movies.getPopularMovies() // roda as requisicao da api
        movieView?.updateNowPlaying(movies: nowPlayingMovies) // atualiza a view
    }
    
    func getPopularMovies(){
         self.popularMovieList = movies.getMovieDetails()
        movieView?.updatePopularMovies(movies: popularMovieList!.results)
    var maior = 0.0
    var movieView: MovieListView?
    }
    
    func getMovie(id : Int){
        let idMovie = id
        self.movieListDetails_ID = movies.getMovieDetails_ID(id: idMovie)
    }
    
    func searchMovie(title search: String){
        self.filteredMovies.moviesInList = self.nowPlayingMovies.moviesInList.filter(({(movie:Movie) -> Bool in
            return movie.title?.lowercased().contains(search.lowercased()) ?? false
        }))
        print(self.filteredMovies.moviesInList)
    }
    
}

