//
//  SearchNormal.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
import UIKit
final class SearchNormal{
    var id :Int
    var name:String
    var type:Int
    var team_type: String
    var sd_id :Int
    var encode_sd_id: Int
    var logo: String
    var logo_Image : UIImage?
    var description: String
    var hot: Int
    var channel_id:Int
    init(json:JSON) {
        self.id = json["id"] as! Int
        self.name = json["name"] as! String
        self.type = json["type"] as? Int ?? 0
        self.team_type = json["team_type"] as? String ?? ""
        self.sd_id = json["sd_id"] as? Int ?? 0
        self.encode_sd_id = json["encode_sd_id"] as! Int
        self.logo = json["logo"] as? String ?? ""
        self.description = json["description"] as! String
        self.hot = json["hot"] as! Int
        self.channel_id = json["channel_id"] as? Int ?? 0
    }
}
