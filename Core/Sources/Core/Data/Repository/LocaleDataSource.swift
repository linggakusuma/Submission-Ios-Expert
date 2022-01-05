//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Combine

public protocol LocaleDateSource {
  associatedtype Request
  associatedtype Response
  
  func list(request: Request?) -> AnyPublisher<[Response], Error>
  func add(entities: Request?) -> AnyPublisher<Bool, Error>
  func get(id: Int32) -> AnyPublisher<Response, Error>
}
