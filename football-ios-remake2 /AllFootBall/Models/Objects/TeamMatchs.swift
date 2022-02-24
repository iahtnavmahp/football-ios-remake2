//
//  TeamMatchs.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
import UIKit
final class TeamMatchs {
    var match_id : String
    var team_A_name : String
    var team_B_name : String
    var team_A_logo : String
    var team_A_logo_img : UIImage?
    var team_B_logo : String
    var team_B_logo_img : UIImage?
    var fs_A : String
    var fs_B : String
    var start_play : String
    init(json: JSON){
        self.match_id = json["match_id"] as! String
        self.team_A_name = json["team_A_name"] as! String
        self.team_B_name = json["team_B_name"] as! String
        self.team_A_logo = json["team_A_logo"] as! String
        self.team_B_logo = json["team_B_logo"] as! String
        self.fs_A = json["fs_A"] as! String
        self.fs_B = json["fs_B"] as! String
        self.start_play = json["start_play"] as! String
    }
}
