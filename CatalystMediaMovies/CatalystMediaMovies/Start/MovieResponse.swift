//
//  MovieResponse.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 12/12/24.
//

struct MoviesResponse: Decodable {
    let results: [Movie]
}



struct Movie: Decodable {
    let id : Int
    let title : String
    let overview : String
    let poster_path : String
}
