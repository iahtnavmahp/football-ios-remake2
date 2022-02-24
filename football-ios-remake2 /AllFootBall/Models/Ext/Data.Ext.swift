//
//  Data.Ext.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 05/07/2021.
//

import Foundation
typealias JSON = [String: Any]
typealias JSON2 = [Any]

extension Data {
    func toJSON() -> JSON {
        var json: [String: Any] = [:]
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSON {
                json = jsonObj
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
    func toJSON2() -> JSON2 {
        var json: [Any] = []
        do {
            if let jsonObj = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as? JSON2 {
                json = jsonObj
            }
        } catch {
            print("JSON casting error")
        }
        return json
    }
}
