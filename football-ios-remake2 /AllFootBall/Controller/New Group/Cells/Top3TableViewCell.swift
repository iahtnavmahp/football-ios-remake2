//
//  Top3TableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/07/2021.
//

import UIKit

class Top3TableViewCell: UITableViewCell {
    @IBOutlet weak var bgrImage: UIImageView!
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
