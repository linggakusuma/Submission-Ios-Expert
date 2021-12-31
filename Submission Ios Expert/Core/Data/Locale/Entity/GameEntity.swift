//
//  GameEntity.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 13/09/21.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @objc dynamic var id: Int32 = 0
    @objc dynamic var name: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
