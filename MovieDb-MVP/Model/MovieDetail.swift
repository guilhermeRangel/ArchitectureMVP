//
//  MovieDetail.swift
//  MovieDb-MVP
//
//  Created by Guilherme Rangel on 15/08/19.
//  Copyright © 2019 Guilherme Rangel. All rights reserved.
//

import Foundation

struct headerDetails : Codable{
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results : [MovieDetail]
}

struct MovieDetail : Codable {
    var popularity : Double?
    var vote_count : Int?
    var video : Bool?
    var poster_path : String?
    var id : Int?
    var adult : Bool?
    var backdrop_path : String?
    var original_language : String?
    var original_title : String?
    var genre_ids : [Int]?
    var title : String?
    var vote_average : Double?
    var overview : String?
    var release_date : String?

    
}


