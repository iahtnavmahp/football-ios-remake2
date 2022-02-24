//
//  SettingTableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 27/07/2021.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    @IBOutlet weak var imgSetting: UIImageView!
    @IBOutlet weak var lblSetting: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
