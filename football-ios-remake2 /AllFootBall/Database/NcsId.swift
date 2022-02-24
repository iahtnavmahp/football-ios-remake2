//
//  NcsId.swift
//  AllFootBall
//
//  Created by Pham Van Thai on 21/08/2021.
//

import Foundation
import RealmSwift
class NcsId: Object {
    @objc dynamic var nscId: String = ""
    override static func primaryKey() -> String? {
        return "nscId"
    }
    convenience init(nscId: String) {
        self.init()
        self.nscId = nscId
        
    }
    static func saveNotification(nscId: String) {
        let realm = try! Realm()
        let data = NcsId()
        
        data.nscId = nscId
        
        try! realm.write {
            realm.add(data, update: .modified)
            print("them match id thanh cong")
        }
        
    }
    static func deleteNotification(nscId: String) {
        let realm = try! Realm()
        let dataFilters = realm.objects(NcsId.self).filter("nscId = %@", nscId)
        try! realm.write {
            realm.delete(dataFilters)
            print("xoa match id thanh cong")
        }
    }
    static func isId(id:String) -> Bool{
        let realm = try! Realm()
        let arr = realm.objects(NcsId.self).filter("nscId == '\(id)'")
        if arr.count == 0{
            return true
        }else{
            return false
        }
        
    }
}
