//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct AddGameLocaleDataSource: LocaleDateSource {
  
  public typealias Request = GameModuleEntity
  public typealias Response = Bool
  
  private let _realm: Realm?
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: GameModuleEntity?) -> AnyPublisher<[Bool], Error> {
    fatalError()
  }
  
  public func add(entities: GameModuleEntity?) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self._realm {
        do {
          let entity = realm.object(ofType: GameModuleEntity.self, forPrimaryKey: entities?.id)
          try realm.write {
            if let gameEntity = entity {
              realm.delete(gameEntity)
              completion(.success(false))
            } else {
              realm.add(entities!, update: .all)
              completion(.success(true))
            }
          }
        } catch {
          completion(.failure(DatabaseError.requestFailed))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
    
  }
  
  public func get(id: Int32) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
}
