//
//  LocaleDataSource.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 13/09/21.
//

import Foundation
import RealmSwift
import Combine

protocol LocaleDataSourceProtocol: AnyObject {
    func addFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error>
    func getFavorites() -> AnyPublisher<[GameEntity], Error>
    func getFavorite(id: Int32) -> AnyPublisher<Bool, Error>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    
    private init(realm: Realm?){
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = { realmDatabase in
        return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource : LocaleDataSourceProtocol {
    
    func addFavorite(from game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let entity = realm.object(ofType: GameEntity.self, forPrimaryKey: game.id)
                    try realm.write {
                        if let gameEntity = entity {
                            realm.delete(gameEntity)
                            completion(.success(false))
                        } else {
                            realm.add(game, update: .all)
                            completion(.success(true))
                        }
                    }
                }catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavorites() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = realm.objects(GameEntity.self)
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
    
    func getFavorite(id: Int32) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                let entity = realm.object(ofType: GameEntity.self, forPrimaryKey: id)
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

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}



