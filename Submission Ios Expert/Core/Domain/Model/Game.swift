//
//  Game.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation

struct Game : Equatable, Identifiable{
    let id: Int32
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let description: String
    var isFavorite: Bool
}
