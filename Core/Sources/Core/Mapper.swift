//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Foundation

public protocol Mapper {
  associatedtype Request
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToDomain(request: Request?, response: Response) -> Domain
  func transformDomainToEntity(domain: Domain) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}
