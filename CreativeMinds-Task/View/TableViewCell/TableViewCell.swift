//
//  TableViewCell.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/27/21.
//

import UIKit
// protcol to delegate the tableView cell functions to HomeVC
protocol cellProtocol: class {
    func showAllBtnTapped(movies: [Results], category: Category)
    func movieTapped(movie: Results)
}

class TableViewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showAllBtn: UIButton!
    
    //MARK:- Properties
    weak var delegate: cellProtocol?
    var cellCategory: Category!
    var fetchedMovies = [Results]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionSetub()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        tableSetup()
    }
    
    func configure(category: Category) {
        cellCategory = category
    }

    //MARK:- Actions
    @IBAction func showAllBtnPressed(_ sender: UIButton) {
        // send movies and category to HomeVC to perform pushing CategoryVC
        delegate?.showAllBtnTapped(movies: fetchedMovies, category: cellCategory)
    }

}

//MARK:- CollectionView Delegate & DataSource
extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return fetchedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
            cell.configure(movie: fetchedMovies[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 120, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // send movies and category to HomeVC to perform pushing CategoryVC
        delegate?.movieTapped(movie: fetchedMovies[indexPath.row])
    }
}

//MARK:- Private Methods
extension TableViewCell {
    // dedect this cell from which category
    private func tableSetup() {
        switch cellCategory {
        case .topRated:
            categoryLbl.text = "Top Rated".localized
            getMovies(category: "top_rated")
            
        case .popular:
            categoryLbl.text = "Popular".localized
            getMovies(category: "popular")


        case .comingSoon:
            categoryLbl.text = "Coming Soon".localized
            getMovies(category: "upcoming")

        case .nowPlaying:
            categoryLbl.text = "Now Playing".localized
        getMovies(category: "now_playing")

        default:
            categoryLbl.text = ""
        }
    }
    
   private func collectionSetub() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.reloadData()
    }
    
    // perform network call to fetch movies
    private func getMovies(category: String) {
        let baseUrl = "http://api.themoviedb.org/3/movie/"
        let category = category
        let url = "\(baseUrl)\(category)"
        
        APIService.shared.getData(url: url) { (movies: ResponseModel?, error) in
            if let error = error {
                print(error)
                
            }
            else {
                guard let movies = movies else { return }
                self.fetchedMovies = movies.results!
            }
        }
    }
}
