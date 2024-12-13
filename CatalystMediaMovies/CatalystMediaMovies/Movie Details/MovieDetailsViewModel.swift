//
//  MovieDetailsViewModel.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 13/12/24.
//

import Foundation

class MovieDetailsViewModel: NSObject {
    
    private var apiService: MovieDetailsAPIService!
    
    private(set) var posterData: Data! {
        didSet {
            self.bindPosterDataToController()
        }
    }
    
    var bindPosterDataToController: (() -> ()) = { }

    
    private(set) var movDet: MovDet! {
        didSet {
            self.bindMovDetDataToController()
        }
    }
    
    var bindMovDetDataToController: (() -> ()) = { }

    
    
    override init() {
        super.init()
        self.apiService = MovieDetailsAPIService()
    }
    
    
    func callFuncToGetPosterData(md: MovieDetails) {
        self.apiService.fetchMoviePoster(md: md) { (pd) in
            self.posterData = pd
        }
    }

    func callFuncToGetMovieDetails(movie: MovieDetails) {
        self.apiService.fetchMovieDetails(md: movie) { (md) in
            self.movDet = md
        }
    }
    
}
