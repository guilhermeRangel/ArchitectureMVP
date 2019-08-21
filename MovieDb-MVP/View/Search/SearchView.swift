//
//  SearchView.swift
//  MovieDb-MVP
//
//  Created by Alexandre Scheer Bing on 20/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

protocol SearchView: NSObjectProtocol{
    func updateQuery(query: String)
    func getMovies(movieList: MovieList)
}
