//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Core
import Combine

public struct GetGamesRepository<
  RemoteDataSource: DataSource,
  Transformer: Mapper>: Repository
where
RemoteDataSource.Response == [GameModuleResponse],
Transformer.Response == [GameModuleResponse],
Transformer.Entity == [GameModuleEntity],
Transformer.Domain == [GameModuleModel] {
  
  public typealias Request = Any
  public typealias Response = [GameModuleModel]
  
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer
  ) {
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<[GameModuleModel], Error> {
    return self._remoteDataSource.execute(request: nil)
      .map { _mapper.transformResponseToDomain(request: nil, response: $0)}
      .eraseToAnyPublisher()
  }
}
