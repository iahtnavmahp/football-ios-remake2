//
//  API.TabRankTeam.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 30/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringTabRankTeams {
        func SearchTabRankTeamsDomain(idparam:String) -> String {
            let a =   APIManager.Path.tab_team_rank_first +
                "\(idparam)" +
                APIManager.Path.tab_team_rank_end
            print("search tabrankteam: \(a)")
            return a
        }
    }
    
    
    struct SearchTabRankTeamsResult {
        var tabrankteams : [TabRankTeam]
        
    }
    
    static func getTabRankTeams( param:String,completion: @escaping APICompletion<SearchTabRankTeamsResult>) {
        let urlString = QueryStringTabRankTeams().SearchTabRankTeamsDomain(idparam: param)
        
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [Any] {
                let json = result
                var tabrankteams:[TabRankTeam] = []
                var itemCount = 0
                for item in json {
                    let tabrankteam = TabRankTeam(json: item as! JSON)
                    
                    if tabrankteam.sub_tabs.count > 1{
                        APIManager.FootBall.getTeamRank(param: tabrankteam.sub_tabs[1].url){ (result) in
                            switch result {
                            case .failure(let error):
                                print(error)
                            case .success(let teamRankResult):
                                tabrankteam.teamRank = teamRankResult.teamranks
                                tabrankteams.append(tabrankteam)
                                itemCount = itemCount + 1
                                if itemCount == json.count {
                                    let tabRankTeamsResult = SearchTabRankTeamsResult(tabrankteams: tabrankteams)
                                    completion(.success(tabRankTeamsResult))
                                }
                            }
                        }
                    }
                    
                }
                
            } else {
                //call back
                completion(.failure(.error("Data is not format.")))
            }
        }
    }
}
