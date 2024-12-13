//
//  TrendingMovieImageCell.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 06/12/24.
//

import UIKit

class TrendingMovieImageCell: UICollectionViewCell {
    
    @IBOutlet weak var movImageVw: UIImageView!
    
    private var tmViewModel: TMViewModel!
    
    func setTheViewModel()
    {
        self.tmViewModel = TMViewModel()
    }
    
    func getTMMoviePoster(movie:Movie) {
        self.tmViewModel.callFuncToGetTMMoviePoster(movie: movie)
        
        self.tmViewModel.bindImageDataToTMCell =  {
            self.movImageVw.image = UIImage(data: self.tmViewModel.tmImageData!)
        }
    }
    

}
