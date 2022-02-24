//
//  Tournaments.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/08/2021.
//

import Foundation
class Tournaments{
    var paramId: String
    var TournamentsName :String
    var isTypes:Int
    var isCall : Bool
    
    init(paramId: String,TournamentsName:String,isTypes:Int,isCall:Bool) {
        self.paramId = paramId
        self.TournamentsName = TournamentsName
        self.isTypes = isTypes
        self.isCall = isCall
        
        
    }
}
