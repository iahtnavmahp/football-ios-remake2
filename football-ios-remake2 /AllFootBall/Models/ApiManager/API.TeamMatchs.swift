//
//  API.TeamMatchs.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringSearhTeamMatchs {
        func SearchTeamMatchsDomain(idparam:String) -> String {
            let a =   APIManager.Path.search_teammatch_first +
                "\(idparam)" +
                APIManager.Path.search_teammatch_end
            print("search teammatch: \(a)")
            return a
        }
    }
    
    struct SearchTeamMatchsResult {
        var teammatchs : [TeamMatchs]
        
    }
    
    static func getSearchTeamMatchs(id:String, completion: @escaping APICompletion<SearchTeamMatchsResult>) {
        let urlString = QueryStringSearhTeamMatchs().SearchTeamMatchsDomain(idparam: id)
        
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                var teammatchs:[TeamMatchs] = []
                if let list = json["list"] as? [JSON] {
                    for item in list{
                        let teammatch = TeamMatchs(json: item)
                        teammatchs.append(teammatch)
                    }
                    
                }
                
                //informations
                let searchTeamMatchsResult = SearchTeamMatchsResult(teammatchs: teammatchs)
                
                //call back
                completion(.success(searchTeamMatchsResult))
                // result
                
            } else {
                //call back
                completion(.failure(.error("Data is not format.")))
            }
        }
    }
}
