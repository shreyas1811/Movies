//
//  MovieDetailsAPIService.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 13/12/24.
//

import Foundation

class MovieDetailsAPIService: NSObject {
    
    func fetchMoviePoster(md: MovieDetails, completion: @escaping (Data) -> ())
    {
    
        if let url = URL(string: "https://image.tmdb.org/t/p/w500\(md.poster_path!)")
        {
            print(url.absoluteString)
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
    
    func fetchMovieDetails(md: MovieDetails, completion: @escaping (MovDet) ->())
    {
                
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(md.id!)")
        {
            
            let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
            
            NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<MovDet, NetworkError>) in
                switch result {
                case .success(let post):
                    print("Post: \(post)")
                    
                    //self.selMovieDetails?.release_date = post.release_date
                    //self.selMovieDetails?.runtime = post.runtime
                    
                    DispatchQueue.main.async {
                        completion(post)
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }

}
