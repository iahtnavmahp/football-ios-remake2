//
//  TeamRank.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/07/2021.
//

import Foundation
final class TeamRank {
    var rank: String
    var team_id:String
    var team_logo:String
    var team_name:String
    init(json:JSON) {
        self.rank = json["rank"] as? String ?? ""
        self.team_id = json["team_id"] as? String ?? ""
        self.team_logo = json["team_logo"] as? String ?? ""
        self.team_name = json["team_name"] as? String ?? ""
        
    }
}
