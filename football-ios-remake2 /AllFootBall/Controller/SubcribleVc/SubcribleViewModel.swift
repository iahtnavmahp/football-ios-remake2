//
//  SubcribleViewModel.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation
typealias Completion1 = (Bool, String) -> Void
class SubcribleViewModel {
    var searchnormals:[SearchNormal] = []
    var searchsuggests:[SearchSuggest] = []
    var searchsamples:[SearchSample] = []
    
    var teamplayers:[TeamPlayer] = []
    
    func loadAPISearchSuggest(str:String,completion: @escaping Completion1) {
        let stringWithoutSpaces = str.replacingOccurrences(of: " ", with: "%20")
        self.searchsuggests.removeAll()
        APIManager.FootBall.getSearchSuggest(str:stringWithoutSpaces){ (result) in
            switch result {
            case .failure(let error):
                //call back
                completion(false, error.localizedDescription)
                
            case .success(let searchsuggestResult):
                
                self.searchsuggests.append(contentsOf: searchsuggestResult.searchsuggest)
                //call back
                completion(true, "")
            }
        }
    }
    
    func loadAPISearchNormal(str:String, completion: @escaping Completion1){
        
        let stringWithoutSpaces = str.replacingOccurrences(of: " ", with: "%20")
        self.searchnormals.removeAll()
        APIManager.FootBall.getSearchNormal(str: stringWithoutSpaces ){(result) in
            switch result {
            case .failure(let error):
                //call back
                completion(false, error.localizedDescription)
                
            case .success(let searchnormalResult):
                
                self.searchnormals.append(contentsOf: searchnormalResult.searchnormal)
                
                //call back
                completion(true, "")
            }
        }
    }
    
    func loadAPISearchSample(id:String,completion: @escaping Completion1)  {
        
        APIManager.FootBall.getSearchSample(id:id){(result) in
            switch result {
            case .failure(let error):
                //call back
                completion(false, error.localizedDescription)
                
            case .success(let searchsampleResult):
                self.searchsamples.append(contentsOf: searchsampleResult.searchsample)
                //call back
                completion(true, "")
            }
        }
        
    }
    
    
    
}
