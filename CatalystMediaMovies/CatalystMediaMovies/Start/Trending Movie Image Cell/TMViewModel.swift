//
//  TMViewModel.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 12/12/24.
//

import Foundation

class TMViewModel: NSObject {
    
    private var apiService: TMAPIService!
    
    private(set) var tmImageData: Data? {
        didSet {
            self.bindImageDataToTMCell()
        }
    }

    var bindImageDataToTMCell: (() -> ()) = { }

    
    func callFuncToGetTMMoviePoster(movie: Movie) {
        self.apiService = TMAPIService()
        self.apiService.getTheTMMoviePoster(movie: movie) { (data) in
            self.tmImageData = data
        }
    }

}

