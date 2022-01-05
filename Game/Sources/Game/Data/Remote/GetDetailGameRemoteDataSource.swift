//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Core
import Alamofire
import Combine
import Foundation

public struct GetDetailGameDataSource: DataSource {
  public typealias Request = Int32
  public typealias Response = GameModuleResponse
  
  private let _endpoint: String
  
  public init(endpoint: String) {
    _endpoint = endpoint
  }
  
  public func execute(request: Int32?) -> AnyPublisher<GameModuleResponse, Error> {
    return Future<GameModuleResponse, Error> { completion in
      if let url = URL(string: "\(_endpoint)\(request ?? 0)?key=3cc4846006ef4df399de0b6f7a3a2892") {
        AF.request(url)
          .validate()
          .responseDecodable(of: GameModuleResponse.self) { response in
            switch response.result {
            case .success(let value):
              completion(.success(value))
            case .failure:
              completion(.failure(URLError.invalidResponse))
            }
          }
      }
    }.eraseToAnyPublisher()
  }
}
