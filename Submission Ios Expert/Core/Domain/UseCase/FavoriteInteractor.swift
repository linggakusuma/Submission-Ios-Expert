//
//  FavoriteInteractor.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 14/09/21.
//

import Foundation
import Combine

protocol FavoriteUseCase {
    func getFavorites() -> AnyPublisher<[Game], Error>
}

class FavoriteInteractor : FavoriteUseCase {
    
    private let repository: GamesRepositoryProtocol
    
    required init(repository: GamesRepositoryProtocol){
        self.repository = repository
    }
    
    func getFavorites() -> AnyPublisher<[Game], Error> {
        repository.getFavorites()
    }
}
