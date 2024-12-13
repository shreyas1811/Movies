//
//  WKTrailerViewController.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 10/12/24.
//

import UIKit
import WebKit
import YouTubeiOSPlayerHelper

class WKTrailerViewController: UIViewController {

    var key: String?
    var movDet: MovieDetails?
    
    @IBOutlet weak var ytPlayerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //trailerWebView.load(URLRequest(url: URL(string: "https://www.youtube.com/watch?v=\(key)")!))
        fetchMovieTrailerDetails()
    }
    

    
    
    
    func fetchMovieTrailerDetails() {
        
        if let selmdID = movDet?.id {
            
            if let url = URL(string: "https://api.themoviedb.org/3/movie/\(selmdID)/videos")
            {
                print(url.absoluteString)
                let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
                
                NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<Trailer, NetworkError>) in
                    switch result
                    {
                    case .success(let post):
                        print("Post: \(post)")
                        
                        if let k = post.results.first?.key
                        {
                            
                            // post.results.first?.key
                            print("The key is = \(k)")
                            
                            DispatchQueue.main.async {
                                if let videoURL = URL(string: "https://www.youtube.com/watch?v=\(k)")
                                {
                                    print("The video url = \(videoURL.absoluteString)")

                                    self.ytPlayerView.load(withVideoId:k)
                                }
                            }
                        }
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
