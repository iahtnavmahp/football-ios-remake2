//
//  TeamInfoViewModel.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 25/07/2021.
//

import Foundation
class TeamInfoViewModel {
    var teammatchs:[TeamMatchs] = []
    var teamplayers:[TeamPlayer] = []
    var searchinfos:[SearchInfo] = []
    
    func loadAPITeamMatchs(id:String,completion: @escaping Completion1)  {
        
        APIManager.FootBall.getSearchTeamMatchs(id:id){(result) in
            switch result {
            case .failure(let error):
                //call back
                completion(false, error.localizedDescription)
                
            case .success(let searchTeamMatchsResult):
                self.teammatchs.append(contentsOf: searchTeamMatchsResult.teammatchs)
                
                //call back
                completion(true, "")
            }
        }
        
    }
    func loadAPITeamPlayer(id:String,completion: @escaping Completion1)  {
        
        APIManager.FootBall.getSearchTeamPlayer(id:id){(result) in
            switch result {
            case .failure(let error):
                //call back
                completion(false, error.localizedDescription)
                
            case .success(let searchTeamPlayerResult):
                self.teamplayers.append(contentsOf: searchTeamPlayerResult.teamplayers)
                
                //call back
                completion(true, "")
            }
        }
        
    }
    func loadAPISearchInfo(id:String,completion: @escaping Completion1)  {
        
        APIManager.FootBall.getSearchInfo(id:id){(result) in
            switch result {
            case .failure(let error):
                //call back
                completion(false, error.localizedDescription)
                
            case .success(let searchInfoResult):
                self.searchinfos.append(contentsOf: searchInfoResult.searchinfo)
                
                //call back
                completion(true, "")
            }
        }
        
        
    }
}
