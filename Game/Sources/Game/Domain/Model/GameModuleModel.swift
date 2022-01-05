//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Foundation

public struct GameModuleModel : Equatable, Identifiable{
  public let id: Int32
  public let name: String
  public let released: String
  public let backgroundImage: String
  public let rating: Double
  public let description: String
  public var isFavorite: Bool
}
