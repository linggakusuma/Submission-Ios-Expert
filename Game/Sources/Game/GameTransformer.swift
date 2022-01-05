//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Core

public struct GameTransformer: Mapper {

  
  public typealias Request = Any
  public typealias Response = [GameModuleResponse]
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [GameModuleModel]
  
  public init(){}
  
  public func transformResponseToDomain(request: Any?, response: [GameModuleResponse]) -> [GameModuleModel] {
    return response.map { result in
      return GameModuleModel(id: result.id, name: result.name, released: result.released, backgroundImage: result.backgroundImage, rating: result.rating, description: result.description ?? "", isFavorite: false)
    }
  }
  
  public func transformDomainToEntity(domain: [GameModuleModel]) -> [GameModuleEntity] {
    return domain.map { game in
      let gameEntity = GameModuleEntity()
      gameEntity.id = game.id
      gameEntity.image = game.backgroundImage
      gameEntity.name = game.name
      gameEntity.releaseDate = game.released
      gameEntity.isFavorite = game.isFavorite
      return gameEntity
    }
  }
  
  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [GameModuleModel] {
    return entity.map { result in
      return GameModuleModel(id: result.id, name: result.name, released: result.releaseDate, backgroundImage: result.image, rating: 0.0, description: "", isFavorite: false)
    }
  }
}
