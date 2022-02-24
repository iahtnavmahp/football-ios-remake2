//
//  TeamPlayer.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
import UIKit
struct Datas {
    
    var person_logo : String
    var person_logo_img :UIImage?
    var person_name : String
    init(json:JSON) {
        self.person_logo = json["person_logo"] as? String ?? ""
        self.person_name = json["person_name"] as? String ?? ""
    }
}
final class TeamPlayer {
    var data : [Datas] = [Datas(json: [:])]
    var title : String
    var isOpened :Bool = false
    init(json:JSON) {
        if let datas = json["data"] as? [[String:Any]] {
            for item in datas {
                let i : Datas = Datas(json: item)
                self.data.append(i)
            }
        }
        self.title = json["title"] as! String
        self.isOpened = false
    }
}
