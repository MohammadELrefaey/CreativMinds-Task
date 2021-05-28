//
//  SideMenuVC.swift
//  CreativeMinds-Task
//
//  Created by Mohamed on 5/28/21.
//

import UIKit

class SideMenuCell: UITableViewCell {
    //MARK:- Outlets
    @IBOutlet weak var contentLbl: UILabel!
    
    //MARK:- Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(content: String) {
        contentLbl.text = content
    }
}
