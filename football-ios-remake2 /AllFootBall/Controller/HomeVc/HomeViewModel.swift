//
//  HomeViewModel.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 04/07/2021.
//

import Foundation
typealias Completion = (Bool, String) -> Void
class HomeViewModel {
    var footballs : [MatchFootBall] = []
    //    var eventgoals : [EventGoal] = []
    
    func loadAPI(completion: @escaping ([MatchFootBall] ,Bool, String) -> Void) {
        APIManager.FootBall.getMatchFootBall{ (result) in
            switch result {
            case .failure(let error):
                //call back
                completion(self.footballs,false, error.localizedDescription)
                
            case .success(let footballResult):
                self.footballs.append(contentsOf: footballResult.footballs)
                
                //call back
                completion(self.footballs,true, "")
            }
        }
    }
    //    func loadAPIGoal(idparam:String,completion: @escaping Completion)  {
    //
    //        APIManager.FootBall.getGoalFootBall(idparam: idparam){ (result) in
    //            switch result {
    //            case .failure(let error):
    //                //call back
    //                completion(false, error.localizedDescription)
    //
    //            case .success(let footballResultGoal):
    //                self.eventgoals.removeAll()
    //                self.eventgoals.append(contentsOf: footballResultGoal.eventgoals)
    //
    //                //call back
    //                completion(true, "")
    //            }
    //        }
    //
    //    }
    
}
