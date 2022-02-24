//
//  OutTop3TableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/07/2021.
//

import UIKit

class OutTop3TableViewCell: UITableViewCell {
    @IBOutlet weak var lblTop: UILabel!
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
