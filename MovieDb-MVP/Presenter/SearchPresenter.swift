//
//  SearchPresenter.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 20/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

class SearchPresenter{
    var searchView: SearchView?
    var resultList = MovieList.init(movies: [])
    var movies = MoviesService()
    
    func attach(_ searchView: SearchView){
        self.searchView = searchView
    }
    
    func updateView(newQuery: String){
        self.searchView?.updateQuery(query: newQuery)
        resultList = movies.getPopularMovies()
        self.searchView?.getMovies(movieList: resultList)
    }
}


