//
//  MovieList.swift
//  MovieDb-MVP
//
//  Created by Guilherme Rangel on 19/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//
import Foundation

class MovieList{
    var moviesInList: [Movie]
    
    init(movies: [Movie]) {
        self.moviesInList = movies
    }
}
