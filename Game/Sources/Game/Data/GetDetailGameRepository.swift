//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Core
import Combine

public struct GetDetailGameRepository<
  GameLocaleDataSource: LocaleDateSource,
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
GameLocaleDataSource.Request == Int32,
GameLocaleDataSource.Response == Bool,
RemoteDataSource.Request == Int32,
RemoteDataSource.Response == GameModuleResponse,
Transformer.Request == Int32,
Transformer.Response == GameModuleResponse,
Transformer.Entity == GameModuleEntity,
Transformer.Domain == GameModuleModel {
  
  public typealias Request = Int32
  public typealias Response = GameModuleModel
  
  private let _localeDataSource: GameLocaleDataSource
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
    localeDataSource: GameLocaleDataSource,
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    _localeDataSource = localeDataSource
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: Int32?) -> AnyPublisher<GameModuleModel, Error> {
    return Publishers.Zip(self._remoteDataSource.execute(request: request), self._localeDataSource.get(id: request ?? 0))
      .flatMap { (detail, isFavorite) ->
        AnyPublisher<GameModuleModel, Error> in
        return Future<GameModuleModel, Error> { completion in
          var detail = _mapper.transformResponseToDomain(request: request, response: detail)
          detail.isFavorite = isFavorite
          completion(.success(detail))
        }.eraseToAnyPublisher()
      }.eraseToAnyPublisher()
      }
}
