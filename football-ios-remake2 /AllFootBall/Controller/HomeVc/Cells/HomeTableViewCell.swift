//
//  HomeTableViewCell.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 02/07/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTeam1: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblGoalTeam1: UILabel!
    @IBOutlet weak var lblGoalTeam2: UILabel!
    @IBOutlet weak var lblGoalTimeTeam1: UILabel!
    @IBOutlet weak var imgTeam1: UIImageView!
    @IBOutlet weak var imgTeam2: UIImageView!
    @IBOutlet weak var btn_Notification: UIButton!
    
    @IBOutlet weak var lblGoalTimeTeam2: UILabel!
    @IBOutlet weak var lblTeam2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        imgTeam1.layer.masksToBounds =  true
        imgTeam1.layer.cornerRadius = imgTeam1.frame.size.width/2.8
        imgTeam2.layer.masksToBounds =  true
        imgTeam2.layer.cornerRadius = imgTeam2.frame.size.height/2.8
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
