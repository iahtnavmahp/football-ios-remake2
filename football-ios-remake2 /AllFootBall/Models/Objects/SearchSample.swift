//
//  SearchSample.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
import UIKit
struct Description {
    var key : String
    var value : String
    init(json:JSON) {
        self.key = json["key"] as? String ?? ""
        self.value = json["value"] as? String ?? ""
    }
}
final class SearchSample{
    var team_id : String
    var team_name: String
    var team_en_name : String
    var team_img : String = ""
    var team_img_logo : UIImage?
    var team_logo_md5: String
    var country_img : String
    var country_img_logo : UIImage?
    var country : String
    var address : String
    var telephone : String
    var email : String
    var city : String
    var founded : String
    var venue_name :String
    var venue_capacity: String
    var color : String
    var rank : String
    var description : [Description] = [Description(json: [:])]
    var league_id : String
    var market_value : String
    var scheme : String
    init(json: JSON) {
        self.team_id = json["team_id"] as? String ?? ""
        self.team_name = json["team_name"] as? String ?? ""
        self.team_en_name = json["team_en_name"] as? String ?? ""
        if let a = json["team_img"] as? String{
            self.team_img = a
        }
        
        self.team_logo_md5 = json["team_logo_md5"] as? String ?? ""
        self.country_img = json["country_img"] as? String ?? ""
        self.country = json["country"] as? String ?? ""
        self.address = json["address"] as? String ?? ""
        self.telephone = json["telephone"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.city = json["city"] as? String ?? ""
        self.founded = json["founded"] as? String ?? ""
        self.venue_name = json["venue_name"] as? String ?? ""
        self.venue_capacity = json["venue_capacity"] as? String ?? ""
        self.color = json["color"] as? String ?? ""
        self.rank = json["rank"] as? String ?? ""
        self.league_id = json["league_id"] as? String ?? ""
        self.market_value = json["market_value"] as? String ?? ""
        self.scheme = json["scheme"] as? String ?? ""
        if let destions = json["description"] as? [[String:Any]]{
            
            for item in destions {
                let des : Description = Description(json: item)
                description.append(des)
                
            }
            
        }
    }
}
