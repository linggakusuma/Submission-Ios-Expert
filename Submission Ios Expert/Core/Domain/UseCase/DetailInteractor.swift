//
//  DetailInteractor.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation
import Combine

protocol DetailUseCase {
    func getDetail() -> AnyPublisher<Game, Error>
    func addFavorite(game: Game) -> AnyPublisher<Bool, Error>
}

class DetailInteractor: DetailUseCase {
    private let repository: GamesRepositoryProtocol
    private let id: Int32
    
    required init(repository: GamesRepositoryProtocol, id: Int32){
        self.repository = repository
        self.id = id
    }
    
    func getDetail() -> AnyPublisher<Game, Error> {
        repository.getDetail(id: id)
    }
    
    func addFavorite(game: Game) -> AnyPublisher<Bool, Error> {
        return self.repository.addFavorite(game: game)
    }
}
