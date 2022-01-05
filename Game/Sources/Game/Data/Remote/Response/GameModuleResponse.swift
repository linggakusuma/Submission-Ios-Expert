//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 04/01/22.
//

import Foundation

public struct GamesModuleResponse : Decodable {
  let results: [GameModuleResponse]
}

public struct GameModuleResponse : Decodable {
  let id: Int32
  let name: String
  let released: String
  let backgroundImage: String
  let rating: Double
  let description: String?
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
    case released
    case backgroundImage = "background_image"
    case rating
    case description = "description_raw"
  }
}
