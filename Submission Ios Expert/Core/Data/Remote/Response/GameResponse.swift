//
//  GameResponse.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation

struct GamesResponse : Decodable {
    let results: [GameResponse]
}

struct GameResponse : Decodable {
    let id: Int32
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
    }
}
