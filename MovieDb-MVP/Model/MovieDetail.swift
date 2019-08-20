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

//struct MovieDetail: Codable {
//    let adult: Bool?
//    let backdrop_path: String?
//    let belongs_to_collection: String?
//    let budget: Int?
//    let genres: [Genres]?
//    let homepage: String?
//    let id: Int?
//    let imdb_id: String?
//    let original_language: String?
//    let original_title: String?
//    let overview: String?
//    let popularity: Double?
//    let poster_path: String?
//    let production_companies: [Production_companies]?
//    let production_countries: [Production_countries]?
//    let release_date: String?
//    let revenue: Int?
//    let runtime: Int?
//    let spoken_languages: [Spoken_languages]?
//    let status: String?
//    let tagline: String?
//    let title: String?
//    let video: Bool?
//    let vote_average: Double?
//    let vote_count: Int?
//
//}
//
//
//struct Spoken_languages : Codable {
//    let iso_639_1: String?
//    let name: String?
//}
//
//struct Production_countries : Codable {
//    let iso_3166_1: String?
//    let name: String?
//}
//
//struct Production_companies : Codable {
//    let id: Int?
//    let logo_path: String?
//    let name: String?
//    let origin_country: String?
//}
//
//struct Genres : Codable {
//    let id: Int?
//    let name: String?
//}
//
