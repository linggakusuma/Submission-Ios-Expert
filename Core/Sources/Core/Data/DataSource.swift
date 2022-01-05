//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Combine

public protocol DataSource {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
