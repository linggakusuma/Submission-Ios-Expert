//
//  RemoteDataSource.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol : AnyObject {
    func getGames() -> AnyPublisher<[GameResponse], Error>
    func getDetailGames(id: Int32) -> AnyPublisher<DetailGameResponse, Error>
}

final class RemoteDataSource: NSObject {
    private override init() {}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getGames() -> AnyPublisher<[GameResponse], Error> {
        return Future<[GameResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.games.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) {response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
    
    func getDetailGames(id: Int32) -> AnyPublisher<DetailGameResponse, Error> {
        return Future<DetailGameResponse, Error> { completion in
            if let url = URL(string: "\(Endpoints.Gets.detail.url)\(id)?key=3cc4846006ef4df399de0b6f7a3a2892"){
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailGameResponse.self){ response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }    
}
