//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Foundation
import RealmSwift

public class GameModuleEntity: Object {
    
    @objc dynamic var id: Int32 = 0
    @objc dynamic var name: String = ""
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var isFavorite: Bool = false
    
  public override class func primaryKey() -> String? {
        return "id"
    }
}

