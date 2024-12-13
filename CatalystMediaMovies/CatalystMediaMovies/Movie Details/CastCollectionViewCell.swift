//
//  CastCollectionViewCell.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 10/12/24.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var castNameLabel: UILabel!
    
    func setTheCastImage(star: Cast) {
        
        
        if let spp = star.profile_path
        {
            print(spp)
            
            if let url = URL(string: "https://image.tmdb.org/t/p/w500\(star.profile_path!)")
            {
                
                NetworkManager.shared.downloadImage(url: url) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                var img = UIImage(data: data)
                                self.castImageView.layer.cornerRadius = self.castImageView.frame.width / 2
                                self.castImageView.image = img
                            }
                        case .failure(let error):
                            print("Failed to load image: \(error)")
                        }
                    }
                }
                
            }
            
        }
    }

    
}
