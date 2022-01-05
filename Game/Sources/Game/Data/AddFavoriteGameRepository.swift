//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Core
import Combine

public struct AddFavoriteGameRepository<
  GameLocaleDataSource: LocaleDateSource,
  Transformer: Mapper>: Repository
where
GameLocaleDataSource.Request == GameModuleEntity,
GameLocaleDataSource.Response == Bool,
Transformer.Request == GameModuleModel,
Transformer.Response == GameModuleResponse,
Transformer.Entity == GameModuleEntity,
Transformer.Domain == GameModuleModel {
  
  
  public typealias Request = GameModuleModel
  
  public typealias Response = Bool
  
  private let _localeDataSource: GameLocaleDataSource
  private let _mapper: Transformer
  
  public init(
    localeDateSource: GameLocaleDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDateSource
    _mapper = mapper
  }
  public func execute(request: GameModuleModel?) -> AnyPublisher<Bool, Error> {
    return self._localeDataSource.add(entities: _mapper.transformDomainToEntity(domain: request!))
  }
}



