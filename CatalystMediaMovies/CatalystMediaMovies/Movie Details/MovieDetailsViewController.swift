//
//  MovieDetailsViewController.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 10/12/24.
//

import UIKit

class MovieDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    
    @IBOutlet weak var movPosterVw: UIImageView!
    @IBOutlet weak var movImgVw: UIImageView!
    @IBOutlet weak var movTitleLbl: UILabel!
    @IBOutlet weak var movDetLbl: UILabel!
    @IBOutlet weak var movDetailsTxtVw: UITextView!
    
    @IBOutlet weak var castCollVw: UICollectionView!
    var castArr: [Cast] = []
    
    var selMovie: Movie?
    var selMovieDetails: MovieDetails?
    
    private var mdViewModel: MovieDetailsViewModel!
    
    @IBOutlet weak var titleCollVw: UICollectionView!
    var acs: [String] = ["About Movie", "Cast"]
    var selTitleIPR = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.movDetailsTxtVw.isHidden = false
        self.castCollVw.isHidden = true
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        self.movPosterVw.isUserInteractionEnabled = true
        self.movPosterVw.addGestureRecognizer(tapGestureRecognizer)
        
        
        self.title = "Details"
        
        
        
        self.selMovieDetails = MovieDetails()
        self.selMovieDetails?.id = self.selMovie!.id
        self.selMovieDetails?.title = self.selMovie!.title
        self.selMovieDetails?.overview = self.selMovie!.overview
        self.selMovieDetails?.poster_path = self.selMovie!.poster_path
        
        self.movTitleLbl.text = self.selMovieDetails?.title
        self.movDetailsTxtVw.text = self.selMovieDetails?.overview
        
        // Do any additional setup after loading the view.
        print("The movie details are as follows: \(self.selMovieDetails?.id!), \(self.selMovieDetails?.poster_path!)")
        
        //fetchMoviePoster()
        
        //fetchMovieDetails()
        
        callToMovieDetailsViewModelForUIUpdate()
    }
    
    func callToMovieDetailsViewModelForUIUpdate()
    {
        self.mdViewModel = MovieDetailsViewModel()
        
        self.mdViewModel.callFuncToGetPosterData(md: self.selMovieDetails!)
        
        self.mdViewModel.callFuncToGetMovieDetails(movie: self.selMovieDetails!)
        
        self.mdViewModel.bindPosterDataToController = {
            var posData = UIImage(data: self.mdViewModel.posterData)
            self.movPosterVw.image = posData
            self.movImgVw.image = posData
        }
        
        
        self.mdViewModel.bindMovDetDataToController = {
            self.selMovieDetails?.runtime = self.mdViewModel.movDet.runtime
            self.selMovieDetails?.release_date = self.mdViewModel.movDet.release_date
            
            if let releaseDate = self.selMovieDetails?.release_date
            {
                if let runtime = self.selMovieDetails?.runtime
                {
                    self.movDetLbl.text = "\(releaseDate)    \(runtime)"
                }
                
            }
            
            
        }
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        print("Poster Tapped")
        // Your action
        
        let wtvc = self.storyboard?.instantiateViewController(withIdentifier: "WKTrailerViewController") as! WKTrailerViewController
        wtvc.movDet = self.selMovieDetails
        self.navigationController?.pushViewController(wtvc, animated: true)
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    
    
    
    
    @IBAction func segmentedControlTapped(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            //     About
            self.movDetailsTxtVw.isHidden = false
            self.castCollVw.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1 {
            // Cast
            self.movDetailsTxtVw.isHidden = true
            self.castCollVw.isHidden = false
            
            fetchCastDetails()
            
        }
        
    }
    
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var c = 0
        
        if collectionView == self.titleCollVw
        {
            if self.acs.count > 0 {
                c = self.acs.count
            }
        }
        else if collectionView == self.castCollVw {
            
            if self.castArr.count > 0 {
                c = self.castArr.count
            }
            
        }
        
        return c
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        var cell = UICollectionViewCell()
        if collectionView == self.titleCollVw
        {
            let  tcell = self.titleCollVw.dequeueReusableCell(withReuseIdentifier: "TitleCollectionViewCell", for: indexPath) as! TitleCollectionViewCell
            tcell.titleLabel.text = self.acs[indexPath.row]
            
            if indexPath.row == self.selTitleIPR {
                tcell.underlineVw.isHidden = false
            }
            else {
                tcell.underlineVw.isHidden = true
            }
                   
            cell = tcell
            
        }
        else if collectionView == self.castCollVw
        {
            let  ccell = self.castCollVw.dequeueReusableCell(withReuseIdentifier: "CastCollectionViewCell", for: indexPath) as! CastCollectionViewCell
            
            let c = self.castArr[indexPath.row]
            ccell.castNameLabel.text = c.name
            ccell.setTheCastImage(star: c)
            cell = ccell
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        if collectionView == self.titleCollVw
        {
            self.selTitleIPR = indexPath.row
            self.titleCollVw.reloadData()
            
            if self.selTitleIPR == 0
            {
                //     About Movie
                self.movDetailsTxtVw.isHidden = false
                self.castCollVw.isHidden = true

            }
            else if self.selTitleIPR == 1
            {
                // Cast
                self.movDetailsTxtVw.isHidden = true
                self.castCollVw.isHidden = false
                
                fetchCastDetails()
            }
        }
    }
    
    
    
    func fetchCastDetails()
    {
        guard let movdet:MovieDetails = selMovieDetails else { return }
        
        if let url = URL(string: "https://api.themoviedb.org/3/movie/\(movdet.id!)/credits")
        {
            print(url.absoluteString)
            let hs:[String: String] = ["Content-Type":"application/json", "Authorization":"Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNTRhZDhmOTAxN2NlZDg1ZTFiNDVmMDA2ZjUwZDRhMCIsIm5iZiI6MTczMjI3OTA4Ni4zOTY0MDgzLCJzdWIiOiI2NzQwNWJjODAxNWQyZTBmNzAyZGZlYjgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.yR0i-ZOZlJ_wUQN6HUSwVYj4phQGL9ZnXqDl3Up6Q8w"]
            
            NetworkManager.shared.request(url: url, method: .get, headers: hs) { (result: Result<Credits, NetworkError>) in
                switch result {
                case .success(let post):
                    print("Post Credits: \(post)")
                    
                    self.castArr = post.cast
                    DispatchQueue.main.async {
                        self.castCollVw.reloadData()
                    }
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        
    }
    
}














