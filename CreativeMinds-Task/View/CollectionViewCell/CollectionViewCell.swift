//
//  CollectionViewCell.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/27/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
//MARK:- properties
    // baser URL for movie poster
    let baseUrl = "http://image.tmdb.org/t/p/w185/"
    
//MARK:- outlets
    @IBOutlet weak var movieImg: RoundedImageViews!

//MARK:- life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(movie: Results) {
        guard let posterPath = movie.poster_path else {return}
        let url = URL(string: "\(baseUrl)\(posterPath)")
        movieImg.kf.setImage(with: url)
    }
}
