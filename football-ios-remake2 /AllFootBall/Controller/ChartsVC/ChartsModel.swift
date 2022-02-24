//
//  ChartsModelView.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/07/2021.
//

import Foundation
class ChartsModel {
    var tabrankteams : [TabRankTeam] = []
//    var arrtabrankteams : [[TabRankTeam]] = [[]]
    
    func loadAPITabRankTeams(param:String,completion: @escaping Completion1)  {
        
        APIManager.FootBall.getTabRankTeams(param:param){(result) in
            switch result {
            case .failure(let error):
                //call back
                completion(false, error.localizedDescription)
                
            case .success(let tabRankTeamsResult):
                self.tabrankteams.removeAll()
                self.tabrankteams.append(contentsOf: tabRankTeamsResult.tabrankteams)
//                self.arrtabrankteams.append(self.tabrankteams)
                //call back
                completion(true, "")
            }
        }
        
        
    }
    
}
