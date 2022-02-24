//
//  SearchSuggest.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 22/07/2021.
//

import Foundation

final class SearchSuggest {
    var query :String
    init(json:JSON) {
        self.query = json["query"] as! String
    }
    
}
