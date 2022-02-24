//
//  TabRankTeam.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/07/2021.
//

import Foundation
struct SubTabs{
    var title :String
    var url :String
    init(json:JSON) {
        self.title = json["title"] as? String ?? ""
        self.url = json["url"] as? String ?? ""
    }
}
final class TabRankTeam {
    var season_id:String
    var season_name:String
    var last_modify:String
    var teamRank : [TeamRank] = [TeamRank]()
    var sub_tabs: [SubTabs] = [SubTabs(json : [:])]
    init(json:JSON) {
        
        self.season_id = json["season_id"] as? String ?? ""
        self.season_name = json["season_name"] as? String ?? ""
        self.last_modify = json["last_modify"] as? String ?? ""
        if let jsonSub = json["sub_tabs"] as? [[String:Any]]{
            for item in jsonSub {
                let sub : SubTabs = SubTabs(json: item)
                
                self.sub_tabs.append(sub)
            }
        }
    }
}
