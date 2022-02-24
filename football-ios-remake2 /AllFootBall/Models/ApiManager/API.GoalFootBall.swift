//
//  API.GoalFootBall.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 08/07/2021.
//

import Foundation

extension APIManager.FootBall {
    struct QueryStringGoal {
        func GoalFootball(idparam:String) -> String {
            let a =   APIManager.Path.base_domain_match +
                APIManager.Path.event_match_first +
                
                "\(idparam)" +
                APIManager.Path.event_match_end
            
            return a
        }
    }
    
    struct GoalFootBallResult {
        var eventgoals : [EventGoal]
    }
    
    static func getGoalFootBall(idparam:String, completion: @escaping APICompletion<GoalFootBallResult>) {
        let urlString = QueryStringGoal().GoalFootball(idparam: idparam)
        
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                if let events = json["events"] as? [JSON]  {
                    
                    var footballgoals : [EventGoal] = []
                    for item in events {
                        
                        let footballgoal = EventGoal(json: item)
                        
                        footballgoals.append(footballgoal)
                    }
                    //informations
                    let goalBallResult = GoalFootBallResult(eventgoals: footballgoals)
                    
                    //call back
                    completion(.success(goalBallResult))
                    // result
                }
            } else {
                //call back
                completion(.failure(.error("Data is not format.")))
            }
        }
        
    }
}
