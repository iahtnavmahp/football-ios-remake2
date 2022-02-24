//
//  API.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 05/07/2021.
//

import Foundation
//MARK: - Defines
enum APIError: Error {
    case error(String)
    case errorURL
    
    var localizedDescription: String {
        switch self {
        case .error(let string):
            return string
        case .errorURL:
            return "URL String is error."
        }
    }
}
//closure
typealias APICompletion<T> = (Result<T, APIError>) -> Void
//result
enum APIResult {
    case success(Data?)
    case failure(APIError)
}


struct API {
    //singleton
    private static var shareAPI: API = {
        let shareAPI = API()
        return shareAPI
    }()
    
    static func shared() -> API {
        return shareAPI
    }
    
    //init
    private init() {}
}

