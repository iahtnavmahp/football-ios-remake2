//
//  SectionPlayerTableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 25/07/2021.
//

import UIKit

class SectionPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var lblNameSection: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
