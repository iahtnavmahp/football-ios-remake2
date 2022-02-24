//
//  API.SearchSuggest.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringSearchSuggest {
        func SearchSuggestDomain(idparam:String) -> String {
            let a =   APIManager.Path.search_suggest_first +
                "\(idparam)" +
                APIManager.Path.search_suggest_end
            print("search suggest: \(a)")
            return a
        }
    }
    
    
    struct SearchSuggestResult {
        var searchsuggest : [SearchSuggest]
    }
    
    static func getSearchSuggest(str:String, completion: @escaping APICompletion<SearchSuggestResult>) {
        let urlString = QueryStringSearchSuggest().SearchSuggestDomain(idparam: str)
        
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                
                if let datas = json["data"] as? [JSON]  {
                    
                    var searchsuggests : [SearchSuggest] = []
                    for item in datas {
                        
                        let searchsuggest = SearchSuggest(json: item)
                        
                        searchsuggests.append(searchsuggest)
                    }
                    //informations
                    let searchSuggestResult = SearchSuggestResult(searchsuggest: searchsuggests)
                    
                    //call back
                    completion(.success(searchSuggestResult))
                    // result
                }
                
            } else {
                //call back
                completion(.failure(.error("Data is not format.")))
            }
        }
    }
}
