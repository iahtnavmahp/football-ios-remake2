//
//  API.TeamPlayer.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringTeamPlayer {
        func SearchTeamPlayerDomain(idparam:String) -> String {
            let a =   APIManager.Path.search_teamplayer_first +
                "\(idparam)" +
                APIManager.Path.search_teamplayer_end
            print("search info: \(a)")
            return a
        }
    }
    
    struct SearchTeamPlayerResult {
        var teamplayers : [TeamPlayer]
        
        
    }
    
    static func getSearchTeamPlayer(id:String, completion: @escaping APICompletion<SearchTeamPlayerResult>) {
        let urlString = QueryStringTeamPlayer().SearchTeamPlayerDomain(idparam: id)
        
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                var teamplayers:[TeamPlayer] = []
                if let datasss = json["data"] as? JSON {
                    if let lists = datasss["list"] as? [JSON] {
                        for items in lists {
                            let teamplayer = TeamPlayer(json: items)
                            teamplayers.append(teamplayer)
                        }
                    }
                }
                
                //informations
                let searchTeamPlayerResult = SearchTeamPlayerResult(teamplayers: teamplayers)
                
                //call back
                completion(.success(searchTeamPlayerResult))
                // result
                
            } else {
                //call back
                completion(.failure(.error("Data is not format.")))
            }
        }
    }
}
