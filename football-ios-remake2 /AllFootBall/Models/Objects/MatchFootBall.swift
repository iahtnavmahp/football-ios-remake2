//
//  MatchFootBall.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 05/07/2021.
//

import Foundation
import UIKit
struct MatchSK {
    var url:String
    init(json: JSON){
        self.url = json["url"] as? String ??  ""
    }
}
final class MatchFootBall {
    
    var relate_type: String
    var relate_id: String
    var match_id: String
    var competition_id: String
    var competition_name: String
    var competition_logo: UIImage?
    var competition_bk_logo: String
    var gameweek: String
    var status: String
    var minute: String
    var playing_time: String
    var date_utc: String
    var time_utc: String
    var start_play: String
    var end_play: String
    var sort_timestamp: String
    var team_A_id: String
    var team_A_name: String
    var team_A_logo: String
    var team_A_Image: UIImage?
    var team_B_id: String
    var team_B_name: String
    var team_B_logo: String
    var team_B_Image: UIImage?
    var rank_A: String
    var rank_B: String
    var corner_A: String
    var corner_B: String
    var yc_A: String
    var yc_B: String
    var rc_A: String
    var rc_B: String
    var hts_A: String
    var hts_B: String
    var fs_A: String
    var fs_B: String
    var ets_A: String
    var ets_B: String
    var ps_A: String
    var ps_B: String
    var ags_A: String
    var ags_B: String
    var period: String
    var minute_period: String
    var minute_extra: String
    var timestamp: String
    var live_text: String
    var round: String
    var playing_show_time: String
    var matchSK:MatchSK =  MatchSK(json: [:])
    var eventGoal:[EventGoal] = [EventGoal]()
    
    init(json: JSON) {
        self.relate_type = json["relate_type"] as! String
        self.relate_id = json["relate_id"] as! String
        self.match_id = json["match_id"] as! String
        
        self.competition_id = json["competition_id"] as! String
        self.competition_name = json["competition_name"] as! String
        self.competition_bk_logo = json["competition_bk_logo"] as! String
        self.gameweek = json["gameweek"] as! String
        self.status = json["status"] as! String
        self.minute = json["minute"] as! String
        self.playing_time = json["playing_time"] as! String
        self.date_utc = json["date_utc"] as! String
        self.time_utc = json["time_utc"] as! String
        self.start_play = json["start_play"] as! String
        self.end_play = json["end_play"] as! String
        self.sort_timestamp = json["sort_timestamp"] as! String
        self.team_A_id = json["team_A_id"] as! String
        self.team_A_name = json["team_A_name"] as! String
        self.team_A_logo = json["team_A_logo"] as! String
        self.team_B_id = json["team_B_id"] as! String
        self.team_B_name = json["team_B_name"] as! String
        self.team_B_logo = json["team_B_logo"] as! String
        self.rank_A = json["rank_A"] as! String
        self.rank_B = json["rank_B"] as! String
        self.corner_A = json["corner_A"] as! String
        self.corner_B = json["corner_B"] as! String
        self.yc_A = json["yc_A"] as! String
        self.yc_B = json["yc_B"] as! String
        self.rc_A = json["rc_A"] as! String
        self.rc_B = json["rc_B"] as! String
        self.hts_A = json["hts_A"] as! String
        self.hts_B = json["hts_B"] as! String
        self.fs_A = json["fs_A"] as! String
        self.fs_B = json["fs_B"] as! String
        self.ets_A = json["ets_A"] as! String
        self.ets_B = json["ets_B"] as! String
        self.ps_A = json["ps_A"] as! String
        self.ps_B = json["ps_B"] as! String
        self.ags_A = json["ags_A"] as! String
        self.ags_B = json["ags_B"] as! String
        self.period = json["period"] as! String
        self.minute_period = json["minute_period"] as! String
        self.minute_extra = json["minute_extra"] as! String
        self.timestamp = json["timestamp"] as! String
        self.live_text = json["live_text"] as! String
        self.round = json["round"] as! String
        self.playing_show_time = json["playing_show_time"] as! String
        if let sk = json["matchSK"] as? [String:Any]{
            let matchsk:MatchSK = MatchSK(json: sk)//self.matchSK
            self.matchSK = matchsk
        }
        if let matchid = json["match_id"] as? String {
            self.match_id = matchid
        }
        
    }
    
}

