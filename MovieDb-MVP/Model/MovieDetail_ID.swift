import Foundation
struct MovieDetail_ID: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var belongs_to_collection: String?
    var budget: Int?
    var genres: [Genres]?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: [Production_companies]?
    var production_countries: [Production_countries]?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: [Spoken_languages]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?

}


struct Spoken_languages : Codable {
    var iso_639_1: String?
    var name: String?
}

struct Production_countries : Codable {
    var iso_3166_1: String?
    var name: String?
}

struct Production_companies : Codable {
    var id: Int?
    var logo_path: String?
    var name: String?
    var origin_country: String?
}

struct Genres : Codable {
    var id: Int?
    var name: String?
}

