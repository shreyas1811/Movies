//
//  TMViewModel.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 12/12/24.
//

import Foundation

class NPViewModel: NSObject {
    
    private var apiService: NPAPIService!
    
    private(set) var npImageData: Data? {
        didSet {
            self.bindImageDataToNPCell()
        }
    }

    var bindImageDataToNPCell: (() -> ()) = { }

    
    func callFuncToGetNPMoviePoster(movie: Movie) {
        self.apiService = NPAPIService()
        self.apiService.getTheNPMoviePoster(movie: movie) { (data) in
            self.npImageData = data
        }
    }

}

