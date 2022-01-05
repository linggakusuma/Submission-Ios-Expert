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

public struct GetFavoriteGameLocaleDataSource: LocaleDateSource {
  
  public typealias Request = Any
  public typealias Response = GameModuleEntity
  
  private let _realm: Realm?
  
  public init(realm: Realm) {
    _realm = realm
  }

  public func list(request: Any?) -> AnyPublisher<[GameModuleEntity], Error> {
    return Future<[GameModuleEntity], Error> { completion in
      if let realm = self._realm {
        let games: Results<GameModuleEntity> = realm.objects(GameModuleEntity.self)
        completion(.success(games.toArray(ofType: GameModuleEntity.self)))
      } else {
        completion(.failure(DatabaseError.invalidInstance))
      }
    }.eraseToAnyPublisher()
  }
  
  public func add(entities: Any?) -> AnyPublisher<Bool, Error> {
    fatalError()
  }
  
  public func get(id: Int32) -> AnyPublisher<GameModuleEntity, Error> {
    fatalError()
  }
}
