//
//  TeamMatchTableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 24/07/2021.
//

import UIKit

class TeamMatchTableViewCell: UITableViewCell {

    @IBOutlet weak var lblGoalTeam2: UILabel!
    @IBOutlet weak var lblGoalTeam1: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    @IBOutlet weak var lblNameTeam1: UILabel!
    @IBOutlet weak var lblNameTeam2: UILabel!
    @IBOutlet weak var btn_Notification: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
