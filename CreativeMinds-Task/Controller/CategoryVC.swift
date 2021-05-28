//
//  CategoryVC.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/27/21.
//

import UIKit

class CategoryVC: UIViewController {
    //MARK:- outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK:- properties
    var moviesArray = [Results]()
    var category: Category!
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionSetub()
        titleSetup()
    }
}

//MARK:- CollectionView Delegate & DataSource
extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
            cell.configure(movie: moviesArray[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = view.frame.width
        let cellWidth = (width - 30) / 2
        let cellHeght = cellWidth * 1.5
        
        return CGSize(width: cellWidth, height: cellHeght)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToDetailsVC(movie: moviesArray[indexPath.row])
    }
}

//MARK:- Private Methods
extension CategoryVC {
    private func collectionSetub() {
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
         collectionView.reloadData()
     }

    private func titleSetup() {
        switch category {
        case .topRated:
            title = "Top Rated Movies".localized
        
        case .popular:
            title = "Popular Movies".localized
            
        case .comingSoon:
            title = "Coming Soon Movies".localized
        
        case .nowPlaying:
            title = "Now Playing Movies".localized

        default:
            title = ""
        }

    }

    private func goToDetailsVC(movie: Results) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailesVC = Storyboard.instantiateViewController(withIdentifier: "DetailesVC") as! DetailsVC
        detailesVC.movieId = movie.id
        self.navigationController?.pushViewController(detailesVC, animated: true)
     }
    
}
