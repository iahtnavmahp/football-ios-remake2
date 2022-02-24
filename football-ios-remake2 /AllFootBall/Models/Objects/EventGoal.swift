//
//  EvenGoal.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 12/07/2021.
//

import Foundation
struct TeamEvent {
    var event_pic: String
    var person: String
    var person_id:String
    init(json:JSON) {
        
        self.event_pic = json["event_pic"] as? String ?? ""
        self.person = json["person"] as? String ?? ""
        self.person_id = json["person_id"] as? String ?? ""
    }
}

final class EventGoal {
    var  minute: String
    var teamAEvents: [TeamEvent] = [TeamEvent(json: [:])]
    var teamBEvents: [TeamEvent] = [TeamEvent(json: [:])]
    var teamAEvents1: [TeamEvent] = [TeamEvent(json: [:])]
    var teamBEvents1: [TeamEvent] = [TeamEvent(json: [:])]
    init(json:JSON) {
        
        self.minute = json["minute"] as! String
        if let teama = json["teamAEvents"] as? [[String:Any]]{
            
            for item in teama{
                
                let teamaevent:TeamEvent = TeamEvent(json: item)
                if teamaevent.event_pic == "http://img-sd.allfootballapp.com/fastdfs4/M00/C8/DF/ChMf8FyPLpyACp-_AAAIJm3aFSg881.png" {
                    
                    teamAEvents1.append(teamaevent)
                }
                teamAEvents.append(teamaevent)
            }
        }
        if let teamb = json["teamBEvents"] as? [[String:Any]]{
            for item in teamb{
                let teambevent:TeamEvent = TeamEvent(json: item)
                
                if teambevent.event_pic == "http://img-sd.allfootballapp.com/fastdfs4/M00/C8/DF/ChMf8FyPLpyACp-_AAAIJm3aFSg881.png" {
                    self.teamBEvents1.append(teambevent)
                }
                self.teamBEvents.append(teambevent)
                
            }
        }
    }
}
