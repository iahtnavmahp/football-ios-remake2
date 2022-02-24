//
//  NotificationId.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 20/08/2021.
//

import Foundation
import RealmSwift
class NotificationId: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var isNcs: Bool = false
    override static func primaryKey() -> String? {
        return "id"
    }
    convenience init(id: String, isNcs: Bool) {
        self.init()
        self.id = id
        self.isNcs = isNcs
        
        
    }
}
