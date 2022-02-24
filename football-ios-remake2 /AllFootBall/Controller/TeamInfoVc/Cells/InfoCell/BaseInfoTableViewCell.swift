//
//  BaseInfoTableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 25/07/2021.
//

import UIKit

class BaseInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblMid: UILabel!
    @IBOutlet weak var lblLast: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
