//
//  APIConnect.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 16/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

class APIConnect{
    
    let url = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US&page=1")
    var localMovieList = MovieList(movies: [])
    
    var isLoaded = false
    
    func getPopularMovies(){
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {(data, response, error) in
            if let _ = error {
                return
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    guard let moviesResponse = try? decoder.decode(Movies.self, from: data) else { return }
                    
                    self.localMovieList = MovieList(movies: moviesResponse.results)
                    print(self.localMovieList.moviesInList.count)
                    self.isLoaded = true
                }
            }
        }
        task.resume()
    }
    
    func getMovieList()->MovieList{
        return self.localMovieList
    }
    
    
}
