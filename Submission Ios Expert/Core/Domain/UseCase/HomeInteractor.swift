//
//  HomeInteractor.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation
import Combine

protocol HomeUseCase {
    func getGames() -> AnyPublisher<[Game], Error>
}

class HomeInteractor: HomeUseCase {
    
    private let repository: GamesRepositoryProtocol
    
    required init(repository: GamesRepositoryProtocol){
        self.repository = repository
    }
    
    func getGames() -> AnyPublisher<[Game], Error> {
        repository.getGames()
    }
}
