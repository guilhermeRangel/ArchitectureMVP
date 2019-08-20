//
//  MoviesService.swift
//  MovieDb-MVP
//
//  Created by Guilherme Rangel on 19/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation


class MoviesService {
  
    let urlMovies = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US&page=1")
    let urlMoviesDetails = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US&page=1")
    var idMovie = 0
   
    //https://api.themoviedb.org/3/movie/429203?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US
    
    
    var localMovieList = MovieList(movies: [])
    var localMovieDetails = headerDetails(page: nil, total_results: nil, total_pages: nil, results: [])
    var localMovieDetails_ID = MovieDetail_ID()
    
    
    
    func getPopularMovies()->MovieList{
        let session = URLSession.shared
        let task = session.dataTask(with: urlMovies!) {(data, response, error) in
            if let _ = error {
                return
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    guard let moviesResponse = try? decoder.decode(Movies.self, from: data) else { return }
                        self.localMovieList = MovieList(movies: moviesResponse.results)
                    }
                }
            }
            task.resume()
            sleep(3)
            return self.localMovieList
       
    }
    
    
    
    
    
    
    func getMovieDetails() -> headerDetails{
        let session = URLSession.shared
        let task = session.dataTask(with: urlMoviesDetails!) {(data, response, error) in
            if let _ = error {
                return
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    guard let moviesResponse = try? decoder.decode(headerDetails.self, from: data) else { return }
                    
                   // localMovieDetails = moviesResponse.result
                    self.localMovieDetails = moviesResponse
                    
                }
            }
            
        }
        task.resume()
        sleep(3)
       
       
        return self.localMovieDetails

    }
    
    func getMovieDetails_ID(id: Int) -> MovieDetail_ID{
        idMovie = id
        var urlMovieDetails_ID = URL(string:"https://api.themoviedb.org/3/movie/\(idMovie)?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US")
        let session = URLSession.shared
        let task = session.dataTask(with: urlMovieDetails_ID!) {(data, response, error) in
            if let _ = error {
                return
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    guard let moviesResponse = try? decoder.decode(MovieDetail_ID.self, from: data) else { return }
                    
                   self.localMovieDetails_ID = moviesResponse
                    
                }
            }
            
        }
        task.resume()
        sleep(3)
        
        
        return self.localMovieDetails_ID
        
    }
    
}
