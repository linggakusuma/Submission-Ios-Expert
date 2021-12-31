//
//  GameRepository.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation
import Combine

protocol GamesRepositoryProtocol {
    func getGames() -> AnyPublisher<[Game], Error>
    func getDetail(id:Int32) -> AnyPublisher<Game, Error>
    func addFavorite(game: Game) -> AnyPublisher<Bool, Error>
    func getFavorites() -> AnyPublisher<[Game], Error>
}

final class GamesRepository: NSObject {
    typealias GamesInstance = (RemoteDataSource, LocaleDataSource) -> GamesRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: GamesInstance = { remoteRepo, localeRepo in
        return GamesRepository(remote: remoteRepo, locale: localeRepo)
    }
}

extension GamesRepository: GamesRepositoryProtocol {

    func getGames() -> AnyPublisher<[Game], Error> {
        return self.remote.getGames()
            .map{ GameMapper.mapGameResponseToDomain(input: $0) }
            .eraseToAnyPublisher()
    }
    
    func getDetail(id: Int32) -> AnyPublisher<Game, Error> {
        return Publishers.Zip(
            self.remote.getDetailGames(id: id),
            self.locale.getFavorite(id: id)
        )
        .flatMap { (detail, isFavorite) -> AnyPublisher<Game, Error> in
            return Future<Game, Error> { completion in
                var detail = GameMapper.mapDetailGameResponseToDomain(input: detail)
                detail.isFavorite = isFavorite
                completion(.success(detail))
            }.eraseToAnyPublisher()
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(game: Game) -> AnyPublisher<Bool, Error> {
        return self.locale.addFavorite(from: GameMapper.mapGameDomainToEntity(input: game))
    }
    
    func getFavorites() -> AnyPublisher<[Game], Error> {
        return self.locale.getFavorites()
            .map{GameMapper.mapGameEntityToDomain(input: $0)}
            .eraseToAnyPublisher()
    }
}
