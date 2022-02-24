//
//  API.TeamRank.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 31/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringTeamRank {
        func TeamRankDomain(idparam:String) -> String {
            let a =   idparam
            return a
        }
    }
    
    
    struct TeamRankResult {
        var teamranks : [TeamRank]
        
        
    }
    
    static func getTeamRank(param:String, completion: @escaping APICompletion<TeamRankResult>) {
        let urlString = QueryStringTeamRank().TeamRankDomain(idparam: param)
        
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                var teamranks:[TeamRank] = []
                if let content = json["content"] as? JSON{
                    if let rounds = content["rounds"] as? [JSON]{
                        for cont in rounds {
                            if let conts = cont["content"] as? JSON{
                                if let datas = conts["data"] as? [JSON]{
                                    for item in datas{
                                        let teamrank = TeamRank(json:item)
                                        teamranks.append(teamrank)
                                    }
                                }
                            }
                        }
                    }
                    
                    //informations
                    let teamRankResult = TeamRankResult(teamranks: teamranks)
                    
                    //call back
                    completion(.success(teamRankResult))
                    // result
                } else {
                    //call back
                    completion(.failure(.error("Data is not format.")))
                }
            }
        }
    }
}
