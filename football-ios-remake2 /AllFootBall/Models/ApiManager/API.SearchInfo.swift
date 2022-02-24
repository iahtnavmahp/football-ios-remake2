//
//  API.SearchInfo.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringSearchInfo {
        func SearchInfoDomain(idparam:String) -> String {
            let a =   APIManager.Path.search_info_first +
                "\(idparam)" +
                APIManager.Path.search_info_end
            print("search info: \(a)")
            return a
        }
    }
    
    struct SearchInfoResult {
        var searchinfo : [SearchInfo]
        
    }
    
    static func getSearchInfo(id:String, completion: @escaping APICompletion<SearchInfoResult>) {
        let urlString = QueryStringSearchInfo().SearchInfoDomain(idparam: id)
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                var searchinfos:[SearchInfo] = []
                let searchinfo = SearchInfo(json: json)
                searchinfos.append(searchinfo)
                //informations
                let searchInfoResult = SearchInfoResult(searchinfo: searchinfos)
                
                //call back
                completion(.success(searchInfoResult))
                // result
                
            } else {
                //call back
                completion(.failure(.error("Data is not format.")))
            }
        }
    }
}
