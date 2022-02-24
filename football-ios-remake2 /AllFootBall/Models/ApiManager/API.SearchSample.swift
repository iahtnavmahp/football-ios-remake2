//
//  API.SearchSample.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
extension APIManager.FootBall {
    struct QueryStringSearchSample {
        func SearchSampleDomain(idparam:String) -> String {
            let a =   APIManager.Path.search_sample_first +
                "\(idparam)" +
                APIManager.Path.search_sample_end
            print("search sample: \(a)")
            return a
        }
    }
    
    
    struct SearchSampleResult {
        var searchsample : [SearchSample]
    }
    
    static func getSearchSample(id:String ,completion: @escaping APICompletion<SearchSampleResult>) {
        let urlString = QueryStringSearchSample().SearchSampleDomain(idparam: id)
        
        API.shared().requestSON(urlString, param: nil, method: .GET, loading: true) { (result, error) in
            if let result = result as? [String: Any] {
                let json = result
                var searchsamples:[SearchSample] = []
                let searchsample = SearchSample(json: json)
                searchsamples.append(searchsample)
                //informations
                let searchSampleResult = SearchSampleResult(searchsample: searchsamples)
                
                //call back
                completion(.success(searchSampleResult))
                // result
            } else {
                //call back
                completion(.failure(.error("Data is not format.")))
            }
        }
    }
}
