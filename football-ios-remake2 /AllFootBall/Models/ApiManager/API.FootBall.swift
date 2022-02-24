//
//  API.FootBall.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 05/07/2021.
//

import Foundation

extension APIManager.FootBall {
    
    struct QueryString {
        func matchFootball() -> String {
            let a =  APIManager.Path.base_domain +
                APIManager.Path.base_path +
                
                "/matchList?type=important&amp;version=337&amp;platform=iphone&amp;language=en-VN&amp;start=2021-03-1017:00:00&amp;init=1"
            print("main: \(a)")
            return a
        }
    }
    
    struct QueryParam {
    }
    
    struct FootBallResult {
        var footballs : [MatchFootBall]
        
    }
    
    
    static func getMatchFootBall( completion: @escaping APICompletion<FootBallResult>) {
        let urlString = QueryString().matchFootball()
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                let list = json["list"] as! [JSON]
                var footballs : [MatchFootBall] = []
                var itemCount = 0
                for item in list {
                    let football = MatchFootBall(json: item)
                    APIManager.FootBall.getGoalFootBall(idparam: football.match_id){ (result) in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let footballResultGoal):
                            football.eventGoal = footballResultGoal.eventgoals
                            footballs.append(football)
                            itemCount = itemCount + 1
                            if itemCount == list.count {
                                let footBallResult = FootBallResult(footballs: footballs)
                                completion(.success(footBallResult))
                            }
                        }
                    }
                }
                //informations
            }
        }
    }
    
    
    
    
}
