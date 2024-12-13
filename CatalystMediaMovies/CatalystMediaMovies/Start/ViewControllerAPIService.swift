//
//  ViewControllerAPIService.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 12/12/24.
//

import Foundation

class ViewControllerAPIService: NSObject {
    
    func fetchTrendingMoviesNM(completion: @escaping (MoviesResponse) -> ())
    {
        if let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?language=en-US")
        {
            
            let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
            
            NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<MoviesResponse, NetworkError>) in
                switch result {
                case .success(let post):
                    print("Post: \(post)")
                    
                    //self.trendingMovies = post.results
                    DispatchQueue.main.async {
                        completion(post)
                        //self.trendingCollectionVw.reloadData()
                    }

                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
//    func fetchTrendingMovies()
//    {
//        
//        if let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?language=en-US")
//        {
//            var request = URLRequest(url: url)
//            
//            // Set the request HTTP method to GET. This is actually the default if not set, but included here for clarity.
//            request.httpMethod = "GET"
//            
//            // Add your headers here, for example:
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            // Replace `YourAccessToken` with your actual access token for the API
//            request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w", forHTTPHeaderField: "Authorization")
//            
//            // URLSession configuration
//            let config = URLSessionConfiguration.default
//            let session = URLSession(configuration: config)
//            
//            // Create the task to fetch the data
//            let task = session.dataTask(with: request) { (data, response, error) in
//                //Process the data
//                //...
//                //                print("The response is = \(response!)")
//                //                print("**********************************************")
//                do {
//                    
//                    
//                    let decodedData = try JSONDecoder().decode(MoviesResponse.self, from: data!)
//                    
//                    print(decodedData.results)
//                    self.trendingMovies = decodedData.results
//                    DispatchQueue.main.async {
//                        self.trendingCollectionVw.reloadData()
//                    }
//                }
//                catch {
//                    print("Error decoding JSON: \(error)")
//                }
//                
//            }
//            
//            // Start the task
//            task.resume()
//        }
//    }
    
    
    
    
    
    func fetchNowPlayingMovies(completion: @escaping (MoviesResponse) -> ())
    {
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")
        {
            let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
            
            NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<MoviesResponse, NetworkError>) in
                switch result {
                case .success(let post):
                    print("Post Now Playing: \(post)")
                    
                    DispatchQueue.main.async {
                        completion(post)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    
    func fetchUpcomingMovies(completion: @escaping (MoviesResponse) -> ()) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")
        {
            let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
            
            NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<MoviesResponse, NetworkError>) in
                switch result {
                case .success(let post):
                    print("Post Upcoming: \(post)")
                    
                    
                    DispatchQueue.main.async {
                        completion(post)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    
    
    func fetchTopRatedMovies(completion: @escaping (MoviesResponse) -> ()) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated")
        {
            let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
            
            NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<MoviesResponse, NetworkError>) in
                switch result {
                case .success(let post):
                    print("Post Top Rated: \(post)")
                    
                    
                    DispatchQueue.main.async {
                        completion(post)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    
    func fetchPopularMovies(completion: @escaping (MoviesResponse) -> ()) {
        if let url = URL(string: "https://api.themoviedb.org/3/movie/popular")
        {
            let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
            
            NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<MoviesResponse, NetworkError>) in
                switch result {
                case .success(let post):
                    print("Post: \(post)")
                    
                    
                    DispatchQueue.main.async {
                        completion(post)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    
    

    
    
    
    
    
    func getTheNPMoviePoster(movie: Movie, completion:@escaping (Data) -> ())
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
