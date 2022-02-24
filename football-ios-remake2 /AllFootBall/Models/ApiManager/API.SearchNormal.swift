//
//  API.SearchNormal.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringSearchNormal {
        func SearchNormalDomain(idparam:String) -> String {
            let a =   APIManager.Path.search_normal_first +
                "\(idparam)" +
                APIManager.Path.search_normal_end
            print("search normal: \(a)")
            return a
        }
    }
    
    
    struct SearchNormalResult {
        var searchnormal : [SearchNormal]
    }
    
    static func getSearchNormal(str:String, completion: @escaping APICompletion<SearchNormalResult>) {
        let urlString = QueryStringSearchNormal().SearchNormalDomain(idparam: str)
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                if let datas = json["data"] as? JSON{
                    if let entitys = datas["entity"] as? [JSON]{
                        if entitys.count == 0 {
                            print("API.SearchNormal [] = 0")
                        }else{
                            let entity = entitys[0]
                            if let items = entity["items"] as? [JSON]{
                                var searchnormals : [SearchNormal] = []
                                for item in items {
                                    
                                    let searchnormal = SearchNormal(json: item)
                                    if searchnormal.type == 1 {
                                        searchnormals.append(searchnormal)
                                    }
                                    
                                }
                                //informations
                                let searchNormalResult = SearchNormalResult(searchnormal: searchnormals)
                                
                                //call back
                                completion(.success(searchNormalResult))
                                // result
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
