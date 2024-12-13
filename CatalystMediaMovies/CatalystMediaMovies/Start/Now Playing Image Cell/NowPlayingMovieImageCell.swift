//
//  NowPlayingMovieImageCell.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 09/12/24.
//

import UIKit

class NowPlayingMovieImageCell: UICollectionViewCell {
    
    @IBOutlet weak var movImageVw: UIImageView!
    
    private var npViewModel: NPViewModel!
    
    func setTheViewModel()
    {
        self.npViewModel = NPViewModel()
    }
    
    func getNPMoviePoster(movie:Movie) {
        self.npViewModel.callFuncToGetNPMoviePoster(movie: movie)
        
        self.npViewModel.bindImageDataToNPCell =  {
            self.movImageVw.image = UIImage(data: self.npViewModel.npImageData!)
        }
    }
    
}
