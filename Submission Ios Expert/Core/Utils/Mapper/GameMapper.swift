//
//  GameMapper.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation

final class GameMapper {
    static func mapGameResponseToDomain(
        input gameResponse: [GameResponse]
    ) -> [Game] {
        return gameResponse.map{ result in
            return Game(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                description: "",
                isFavorite: false)
        }
    }
    
    static func mapDetailGameResponseToDomain(input detailGameResponse: DetailGameResponse) -> Game {
        return Game(id: detailGameResponse.id,
                    name: detailGameResponse.name,
                    released: detailGameResponse.released,
                    backgroundImage: detailGameResponse.backgroundImage,
                    rating: detailGameResponse.rating,
                    description: detailGameResponse.description,
                    isFavorite: false)
    }
    
    static func mapGameDomainToEntity(input game:Game) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = game.id
        gameEntity.image = game.backgroundImage
        gameEntity.name = game.name
        gameEntity.releaseDate = game.released
        gameEntity.isFavorite = game.isFavorite
        return gameEntity
    }
    
    static func mapGameEntityToDomain(
        input gameEntity: [GameEntity]) -> [Game] {
        return gameEntity.map{result in
            return Game(id: result.id,
                        name: result.name,
                        released: result.releaseDate,
                        backgroundImage: result.image,
                        rating: 0.0,
                        description: "",
                        isFavorite: result.isFavorite)
        }
    }
}
