//
//  MovieListView.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 21/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

protocol MovieListView: NSObjectProtocol {
    func updatePopularMovies(movies: [MovieDetail])
    func updateNowPlaying(movies: MovieList)
}
