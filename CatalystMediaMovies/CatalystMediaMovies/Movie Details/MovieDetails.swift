//
//  MovieDetails.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 13/12/24.
//

struct MovieDetails {
    var id : Int?
    var title : String?
    var overview : String?
    var poster_path : String?
    
    var release_date: String?
    var runtime: Int?
}



struct MovDet: Decodable {
    var release_date: String
    var runtime: Int
}


struct Credits: Decodable {
    let id : Int
    let cast : [Cast]
}

struct Cast: Decodable {
    let id : Int
    let name : String
    let profile_path : String?
}




struct Title {
    var title : String
    var isSelected : Bool
}
