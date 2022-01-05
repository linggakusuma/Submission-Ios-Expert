//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 05/01/22.
//

import Core

public struct AddFavoriteGameTransformer: Mapper {

  
  
  public typealias Request = GameModuleModel
  
  public typealias Response = GameModuleResponse
  
  public typealias Entity = GameModuleEntity
  
  public typealias Domain = GameModuleModel
  
  public init() {}
  
  public func transformResponseToDomain(request: GameModuleModel?, response: GameModuleResponse) -> GameModuleModel {
    return GameModuleModel(id: response.id, name: response.name, released: response.released, backgroundImage: response.backgroundImage, rating: response.rating, description: response.description ?? "", isFavorite: false)
  }
  
  public func transformDomainToEntity(domain: GameModuleModel) -> GameModuleEntity {
    let gameEntity = GameModuleEntity()
    gameEntity.id = domain.id
    gameEntity.image = domain.backgroundImage
    gameEntity.name = domain.name
    gameEntity.releaseDate = domain.released
    gameEntity.isFavorite = domain.isFavorite
    return gameEntity
  }
  
  public func transformEntityToDomain(entity: GameModuleEntity) -> GameModuleModel {
    return GameModuleModel(id: entity.id, name: entity.name, released: entity.releaseDate, backgroundImage: entity.image, rating: 0.0, description: "", isFavorite: entity.isFavorite)
  }
}
