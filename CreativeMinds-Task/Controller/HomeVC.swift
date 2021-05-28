//
//  ViewController.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/25/21.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK:- Properties
    // give table the expected categories fetched from API
    var tableCells = [Category.topRated, Category.popular, Category.comingSoon, Category.nowPlaying]
    
    //MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableSetup()
    }

}
//MARK:- UITableViewDataSource, UITableViewDelegate
extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(category: tableCells[indexPath.row])
        // take delegate from table cell
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }

}


//MARK:- Private Methods
extension HomeVC {
    private func tableSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    
    private func goToCategoryVC(movies: [Results], category: Category) {
        let Storyboard = UIStoryboard(name: "Main", bundle: nil)
        let categoryVC = Storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        categoryVC.moviesArray = movies
        categoryVC.category = category
        self.navigationController?.pushViewController(categoryVC, animated: true)
     }
    
        private func goToDetailsVC(movie: Results) {
            let Storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailesVC = Storyboard.instantiateViewController(withIdentifier: "DetailesVC") as! DetailsVC
            detailesVC.movieId = movie.id
            self.navigationController?.pushViewController(detailesVC, animated: true)
         }
}

extension HomeVC: cellProtocol {
    func movieTapped(movie: Results) {
        goToDetailsVC(movie: movie)
    }
    
    func showAllBtnTapped(movies: [Results], category: Category) {
        goToCategoryVC(movies: movies, category: category)
    }
}


