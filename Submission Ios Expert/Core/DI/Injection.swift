//
//  Injection.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import Foundation
import RealmSwift
import Core
import Game
import UIKit

final class Injection: NSObject {
  
  private func provideRepository() -> GamesRepositoryProtocol {
    let realm = try? Realm()
    
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    
    return GamesRepository.sharedInstance(remote, locale)
  }
  
  func provideHome() -> HomeUseCase {
    let repository = provideRepository()
    return HomeInteractor(repository: repository)
  }
  
  func provideDetail(id: Int32) -> DetailUseCase {
    let repository = provideRepository()
    return DetailInteractor(repository: repository, id: id)
  }
  
  func provideFavorite() -> FavoriteUseCase {
    let repository = provideRepository()
    return FavoriteInteractor(repository: repository)
  }
  
  func provideGame<U: UseCase>() -> U where U.Request == Any, U.Response == [GameModuleModel] {
    
    let remote = GetGamesRemoteDataSource(endpoint: Endpoints.Gets.games.url)
    
    let mapper = GameTransformer()
    
    let repository = GetGamesRepository(remoteDataSource: remote, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideFavoriteGame<U:UseCase>() -> U where U.Request == Any, U.Response == [GameModuleModel] {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetFavoriteGameLocaleDataSource(realm: appDelegate.realm)
    
    let mapper = GameTransformer()
    
    let repository = GetFavoriteGameRepository(localeDataSource: locale, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideDetailGame<U: UseCase>() -> U where U.Request == Int32, U.Response == GameModuleModel {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetGameLocaleDataSource(realm: appDelegate.realm)
    
    let remote = GetDetailGameDataSource(endpoint: Endpoints.Gets.detail.url)
    
    let mapper = DetailGameTransformer()
    
    let repository = GetDetailGameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideAddFavoriteGame<U: UseCase>() -> U where U.Request == GameModuleModel, U.Response == Bool {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = AddGameLocaleDataSource(realm: appDelegate.realm)
    
    let mapper = AddFavoriteGameTransformer()
    
    let repository = AddFavoriteGameRepository(localeDateSource: locale, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
}
