//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 05/01/22.
//

import Core
import Combine
import UIKit

public struct GetFavoriteGameRepository<
  GameLocaleDataSource: LocaleDateSource,
  Transformer: Mapper>: Repository
where
GameLocaleDataSource.Response == GameModuleEntity,
Transformer.Response == [GameModuleResponse],
Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameModuleModel] {
  
  public typealias Request = Any
  public typealias Response = [GameModuleModel]
  
  private let _localeDataSource: GameLocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: GameLocaleDataSource,
    mapper:Transformer
  ) {
    _localeDataSource = localeDataSource
    _mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<[GameModuleModel], Error> {
    return self._localeDataSource.list(request: nil)
      .map {
        _mapper.transformEntityToDomain(entity: $0)
      }.eraseToAnyPublisher()
  }
  
}
