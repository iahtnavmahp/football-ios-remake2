//
//  SearchInfo.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
import UIKit
struct Lists {
    var season_id : Int
    var season_name : String = ""
    init(json: JSON) {
        self.season_id = json["season_id"] as? Int ?? 0
        self.season_name = json["season_name"] as? String ?? ""
    }
}
struct TrophyInfo {
    var competition_id : Int
    var competition_name : String
    var trophy_img : String
    var trophy_img_logo : UIImage?
    var times : Int
    var lists : [Lists] = [Lists(json: [:])]
    init(json : JSON) {
        self.competition_id = json["competition_id"] as? Int ?? 0
        self.competition_name = json["competition_name"] as? String ?? ""
        self.times = json["times"] as? Int ?? 0
        self.trophy_img = json["trophy_img"] as? String ?? ""
        if let ls = json["lists"] as? [[String:Any]] {
            for item in ls {
                let i : Lists = Lists(json: item)
                self.lists.append(i)
            }
        }
    }
}
final class SearchInfo{
    
    var base_info : SearchSample = SearchSample(json: [:])
    var trophy_info : [TrophyInfo] = [TrophyInfo(json: [:])]
    
    init(json:JSON) {
        if let inf = json["base_info"] as? [String:Any]{
            
            let infoo : SearchSample = SearchSample(json: inf)
            
            self.base_info = infoo
        }
        if let trophy = json["trophy_info"] as? [[String:Any]]{
            for item in trophy {
                let trinfo : TrophyInfo = TrophyInfo(json: item)
                self.trophy_info.append(trinfo)
            }
        }
    }
}
