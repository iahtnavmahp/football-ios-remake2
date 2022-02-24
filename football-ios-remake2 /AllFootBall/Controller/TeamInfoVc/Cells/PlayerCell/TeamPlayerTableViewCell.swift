//
//  TeamPlayerTableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 24/07/2021.
//

import UIKit

class TeamPlayerTableViewCell: UITableViewCell {
   
    @IBOutlet weak var imgPlayer: UIImageView!
    @IBOutlet weak var lblNamePlayer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        imgPlayer.layer.masksToBounds = false
       
        imgPlayer.layer.cornerRadius = imgPlayer.frame.height/2
        imgPlayer.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
