//
//  ViewController.swift
//  CatalystMediaMovies
//
//  Created by Shreyas on 05/12/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var trendingMovies: [Movie] = []
    @IBOutlet weak var trendingCollectionVw:UICollectionView!
    
    var nowPlayingMovies: [Movie] = []
    @IBOutlet weak var nowPlayingCollectionVw:UICollectionView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    private var vcViewModel: ViewControllerViewModel!
    
    @IBOutlet weak var titleCollVw: UICollectionView!
    var acs: [String] = ["Now Playing", "Upcoming", "Top Rated", "Popular"]
    var selTitleIPR = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("View Did Load")
        // 1st Coll Vw
        //fetchTrendingMoviesNM()
        // 2nd Coll Vw
        //fetchNowPlayingMovies()
        callToViewControllerViewModelForUIUpdate()
    }
    
    
    func callToViewControllerViewModelForUIUpdate() {
        self.vcViewModel = ViewControllerViewModel()
        
        
        vcViewModel.bindTrendingMoviesToController = {
            // Update DataSource
            self.trendingMovies = self.vcViewModel.trendingMovies
            self.trendingCollectionVw.reloadData()
        }
        
        vcViewModel.bindNowPlayingMoviesToController =  {
            self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
            self.nowPlayingCollectionVw.reloadData()
        }
        
    }
    
    
    
    
    @IBAction func segmentedControlTapped(sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // 	Now Playing
            //fetchNowPlayingMovies()
            self.vcViewModel.callFuncToGetNowPlayingMovies()
            
            vcViewModel.bindNowPlayingMoviesToController =  {
                self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                self.nowPlayingCollectionVw.reloadData()
            }

        }
        else if sender.selectedSegmentIndex == 1 {
            // Upcoming
            //fetchUpcomingMovies()
            self.vcViewModel.callFuncToGetUpcomingMovies()
            
            vcViewModel.bindNowPlayingMoviesToController =  {
                self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                self.nowPlayingCollectionVw.reloadData()
            }

        }
        else if sender.selectedSegmentIndex == 2 {
            // Top Rated
            //fetchTopRatedMovies()
            self.vcViewModel.callFuncToGetTopRatedMovies()
            
            vcViewModel.bindNowPlayingMoviesToController =  {
                self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                self.nowPlayingCollectionVw.reloadData()
            }

        }
        else if sender.selectedSegmentIndex == 3 {
            // Popular
            //fetchPopularMovies()
            self.vcViewModel.callFuncToGetPopularMovies()
            
            vcViewModel.bindNowPlayingMoviesToController =  {
                self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                self.nowPlayingCollectionVw.reloadData()
            }

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
        else if collectionView == self.trendingCollectionVw {
            
            if self.trendingMovies.count > 0 {
                c = self.trendingMovies.count
            }
            //print("The number of items in section \(section) is \(c)")
        }
        else if collectionView == self.nowPlayingCollectionVw {
            if self.trendingMovies.count > 0 {
                c = self.trendingMovies.count
            }
        }
        
        return c
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
        else if collectionView == self.trendingCollectionVw {
            
            
            // get a reference to our storyboard cell
            let tcell = self.trendingCollectionVw.dequeueReusableCell(withReuseIdentifier: "TrendingMovieImageCell", for: indexPath) as! TrendingMovieImageCell
            
            tcell.setTheViewModel()
            
            tcell.getTMMoviePoster(movie: self.trendingMovies[indexPath.row])
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            //        cell.myLabel.text = self.items[indexPath.row] // The row value is the same as the index of the desired text within the array.
            cell = tcell
        }
        else if collectionView == self.nowPlayingCollectionVw {
            
            let  ncell = self.nowPlayingCollectionVw.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieImageCell", for: indexPath) as! NowPlayingMovieImageCell
            
            ncell.setTheViewModel()
            
            ncell.getNPMoviePoster(movie: self.nowPlayingMovies[indexPath.row])
            
            cell = ncell
            
        }
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        var mov: Movie?
        
        if collectionView == self.titleCollVw
        {
            self.selTitleIPR = indexPath.row
            self.titleCollVw.reloadData()
            
            if self.selTitleIPR == 0
            {
                //     Now Playing
                self.vcViewModel.callFuncToGetNowPlayingMovies()
                
                vcViewModel.bindNowPlayingMoviesToController =  {
                    self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                    self.nowPlayingCollectionVw.reloadData()
                }

            }
            else if self.selTitleIPR == 1
            {
                // Upcoming
                self.vcViewModel.callFuncToGetUpcomingMovies()
                
                vcViewModel.bindNowPlayingMoviesToController =  {
                    self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                    self.nowPlayingCollectionVw.reloadData()
                }
                
                
            }
            else if self.selTitleIPR == 2
            {
                // Top Rated
                self.vcViewModel.callFuncToGetTopRatedMovies()
                
                vcViewModel.bindNowPlayingMoviesToController =  {
                    self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                    self.nowPlayingCollectionVw.reloadData()
                }

            }
            else if self.selTitleIPR == 3
            {
                // Popular
                self.vcViewModel.callFuncToGetPopularMovies()
                
                vcViewModel.bindNowPlayingMoviesToController =  {
                    self.nowPlayingMovies = self.vcViewModel.nowPlayingMovies
                    self.nowPlayingCollectionVw.reloadData()
                }

            }
        }
        else if collectionView == trendingCollectionVw {
            mov = self.trendingMovies[indexPath.item]
            let mdvc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
            mdvc.selMovie = mov
            self.navigationController?.pushViewController(mdvc, animated: true)

        }
        else if collectionView == nowPlayingCollectionVw {
            mov = self.nowPlayingMovies[indexPath.item]
            let mdvc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
            mdvc.selMovie = mov
            self.navigationController?.pushViewController(mdvc, animated: true)
        }


        
    }
}








