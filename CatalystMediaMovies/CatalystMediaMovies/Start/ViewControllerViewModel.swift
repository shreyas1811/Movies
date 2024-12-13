//
//  ViewControllerViewModel.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 12/12/24.
//

import Foundation

class ViewControllerViewModel: NSObject {
    
    private var apiService: ViewControllerAPIService!
    
    private(set) var trendingMovies: [Movie] = [] {
        didSet {
            self.bindTrendingMoviesToController()
        }
    }
    
    var bindTrendingMoviesToController: (() -> ()) = { }
    
    
    private(set) var nowPlayingMovies: [Movie] = [] {
        didSet {
            self.bindNowPlayingMoviesToController()
        }
    }
    
    var bindNowPlayingMoviesToController: (() -> ()) = { }
    
    
    

    
    private(set) var npImageData: Data? {
        didSet {
            self.bindImageDataToNPCell()
        }
    }

    var bindImageDataToNPCell: (() -> ()) = { }

    
    override init() {
        super.init()
        self.apiService = ViewControllerAPIService()
        callFuncToGetTrendingMovies()
        callFuncToGetNowPlayingMovies()
    }
    
    func callFuncToGetTrendingMovies() {
        self.apiService.fetchTrendingMoviesNM { (tmData) in
            self.trendingMovies = tmData.results
        }
    }
    
    func callFuncToGetNowPlayingMovies() {
        self.apiService.fetchNowPlayingMovies { (npmData) in
            self.nowPlayingMovies = npmData.results
        }
    }
                   
    func callFuncToGetUpcomingMovies() {
        self.apiService.fetchUpcomingMovies { (upcomingMoviesData) in
            self.nowPlayingMovies = upcomingMoviesData.results
        }
    }
    
    func callFuncToGetTopRatedMovies() {
        self.apiService.fetchTopRatedMovies { (topRatedMoviesData) in
            self.nowPlayingMovies = topRatedMoviesData.results
        }
    }
    
    
    func callFuncToGetPopularMovies() {
        self.apiService.fetchPopularMovies { (popularMoviesData) in
            self.nowPlayingMovies = popularMoviesData.results
        }
    }
                                              
    

    
    
    
    func callFuncToGetNPMoviePoster(movie: Movie) {
        self.apiService.getTheNPMoviePoster(movie: movie) { (data) in
            self.npImageData = data
        }
    }

}
