//
//  DetailesVC.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/28/21.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var posterImg: RoundedImageViews!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var genersLbl: UILabel!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    
    //MARK:- properties
    var movieId: Int!
    var fetchedMovie: Movie! {
        didSet {
            setupVC()
        }
    }
    var geners = [String]()
    var trailerVideo: VideoModel!
    var review: ReviewModel!
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovie(id: movieId)
        getTrailer(id: movieId)
        getReview(id: movieId)
    }
    
    //MARK:- Actions
    @IBAction func playTrailerBtnTapped(_ sender: UIButton) {
        guard let trialerResults = trailerVideo.results else {return}
        guard let trialerId = trialerResults[0].id else {return}
        
        if let url = URL(string: "https://www.youtube.com/watch?v=\(String(trialerId))") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func readMoreBtnTapped(_ sender: UIButton) {
        guard let reviewResults = review.results else {return}
        guard let reviewUrl = reviewResults[0].url else {return}
        
        if let url = URL(string: reviewUrl) {
            UIApplication.shared.open(url)
        }
    }
}

//MARK:- Private Methods
extension DetailsVC {
    
    //network call to get movie detailes with this id
    private func getMovie(id: Int) {
        let baseUrl = "http://api.themoviedb.org/3/movie/"
        let id = id
        let url = "\(baseUrl)\(String(id))"
        
        APIService.shared.getData(url: url) { (movie: Movie?, error) in
            if let error = error {
                print(error)
            }
            else {
                guard let movie = movie else { return }
                self.fetchedMovie = movie
            }
        }
    }
    
    //network call to get trialer video detailes
    private func getTrailer(id: Int) {
        let baseUrl = "http://api.themoviedb.org/3/movie/"
        let id = id
        let url = "\(baseUrl)\(String(id))/videos"
        
        APIService.shared.getData(url: url) { (video: VideoModel?, error) in
            if let error = error {
                print(error)
            }
            else {
                guard let video = video else { return }
                self.trailerVideo = video
            }
        }
    }
    
    //network call to get review detiales with this id
    private func getReview(id: Int) {
        let baseUrl = "http://api.themoviedb.org/3/movie/"
        let id = id
        let url = "\(baseUrl)\(String(id))/reviews"
        
        APIService.shared.getData(url: url) { (review: ReviewModel?, error) in
            if let error = error {
                print(error)
            }
            else {
                guard let review = review else { return }
                self.review = review
            }
        }
    }

    // setup VC UI
    private func setupVC() {
        titleLbl.text = fetchedMovie.title
        rateLbl.text = "\(String(fetchedMovie.vote_average!)) (\(String(fetchedMovie.vote_count!)) Reviews)"
        releaseDateLbl.text = "\(fetchedMovie.release_date!) Released"
        overviewLbl.text = fetchedMovie.overview
        durationLbl.text = "\(String(fetchedMovie.runtime!)) mins"
        guard let generes = fetchedMovie.genres else {return}
        
        // setup generes label
        for gener in generes {
            geners.append(gener.name!)
        }
        genersLbl.text = geners.joined(separator:",")
        
        // get movie poster
        guard let posterPath = fetchedMovie.poster_path else {return}
        let url = URL(string: "http://image.tmdb.org/t/p/w185/" + posterPath)
        posterImg.kf.setImage(with: url)
        
        // get movie cover
        guard let coverPath = fetchedMovie.backdrop_path else {return}
        let urll = URL(string: "http://image.tmdb.org/t/p/w185/" + coverPath)
        coverImg.kf.setImage(with: urll)
        
    }
    


}
