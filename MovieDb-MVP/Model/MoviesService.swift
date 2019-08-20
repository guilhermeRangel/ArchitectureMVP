//
//  MoviesService.swift
//  MovieDb-MVP
//
//  Created by Guilherme Rangel on 19/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation


class MoviesService {
    //9519eb31d39eeca5f505f924c3401dd3
    //GET
    //movie/popular
    //https://api.themoviedb.org/3/movie/popular?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US&page=1
    let urlMovies = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US&page=1")
    
        let urlMoviesDetails = URL(string:"https://api.themoviedb.org/3/movie/popular?api_key=9519eb31d39eeca5f505f924c3401dd3&language=en-US&page=1")
    
    var localMovieList = MovieList(movies: [])
    var localMovieDetails = MovieDetail.init(popularity: nil, vote_count: nil, video: nil, poster_path: nil, id: nil, adult: nil, backdrop_path: nil, original_language: nil, original_title: nil, genre_ids: nil, title: nil, vote_average: nil, overview: nil, release_date: nil)

    
    var isLoaded = false
    
    func getPopularMovies()->MovieList{
        isLoaded = false
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
        //fazer esperar a requisicao corretamente
        
                task.resume()
            sleep(3)
            return self.localMovieList
       
    }
    
    
    
    
    
    
    func getMovieDetails() -> MovieDetail{
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlMoviesDetails!) {(data, response, error) in
            if let _ = error {
                return
            } else {
                if let data = data {
                    let decoder = JSONDecoder()
                    guard let moviesResponse = try? decoder.decode(headerDetails.self, from: data) else { return }
                    
                   print(moviesResponse.results.first?.title)
                    
                }
            }
            
        }
        task.resume()
        sleep(3)
       
       
        return self.localMovieDetails

    }
    
}
