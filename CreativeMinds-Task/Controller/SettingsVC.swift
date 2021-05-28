//
//  SettingsVC.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/28/21.
//

import UIKit
import MOLH

class SettingsVC: UIViewController {
    
    //MARK:- Properties
    var menuArray = ["Language".localized]

    //MARK:- Outlets
    @IBOutlet weak var menuTable: UITableView!
        
    //MARK:- Life Cycle
    override func viewDidLoad() {
    super.viewDidLoad()
    menuTable.delegate = self
    menuTable.dataSource = self
    }
}

//MARK:- UITableViewDataSource, UITableViewDelegate
extension SettingsVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell", for: indexPath) as? SideMenuCell {
            cell.configure(content: menuArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // change app lanaguage and reset apps
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        MOLH.reset()
    }
}

