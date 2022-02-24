//
//  TeamId.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 24/07/2021.
//

import Foundation
import RealmSwift
class TeamId: Object {
    @objc dynamic var id: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: String) {
        self.init()
        self.id = id
        
    }
}
