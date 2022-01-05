//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 05/01/22.
//

import Core
import Combine
import RealmSwift
import Foundation

public struct GetGameLocaleDataSource: LocaleDateSource {
  
  public typealias Request = Int32
  public typealias Response = Bool
  
  private let _realm: Realm?
  
  public init(realm: Realm) {
    _realm = realm
  }
  
  public func list(request: Int32?) -> AnyPublisher<[Bool], Error> {
    fatalError()
  }
  
  public func add(entities: Int32?) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func get(id: Int32) -> AnyPublisher<Bool, Error> {
    return Future<Bool, Error> { completion in
      if let realm = self._realm {
        let entity = realm.object(ofType: GameModuleEntity.self, forPrimaryKey: id)
        if entity == nil {
          completion(.success(false))
        } else {
          completion(.success(true))
        }
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
}
