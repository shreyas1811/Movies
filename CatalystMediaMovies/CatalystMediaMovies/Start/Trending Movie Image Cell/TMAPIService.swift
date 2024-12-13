//
//  TMAPIService.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 12/12/24.
//

import Foundation

class TMAPIService {
    
    func getTheTMMoviePoster(movie: Movie, completion:@escaping (Data) -> ())
    {
        print(movie.poster_path)
        
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
        {
            NetworkManager.shared.downloadImage(url: url) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        
                        DispatchQueue.main.async {
                            completion(data)
                        }
                        
                    case .failure(let error):
                        print("Failed to load image: \(error)")
                    }
                }
            }

        }

    }

}
