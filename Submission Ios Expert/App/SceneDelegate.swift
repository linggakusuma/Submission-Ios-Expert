//
//  SceneDelegate.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import UIKit
import SwiftUI
import Core
import Game

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    let homeUseCase: Interactor<Any, [GameModuleModel],GetGamesRepository<GetGamesRemoteDataSource, GameTransformer>> = Injection.init().provideGame()
    let favoriteUseCase: Interactor<Any, [GameModuleModel], GetFavoriteGameRepository<GetFavoriteGameLocaleDataSource, GameTransformer>> = Injection.init().provideFavoriteGame()
    
    let homePresenter = GetListPresenter(useCase: homeUseCase)
    let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
    
    let contentView = ContentView()
      .environmentObject(homePresenter)
      .environmentObject(favoritePresenter)
    
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      window.rootViewController = UIHostingController(rootView: contentView)
      self.window = window
      window.makeKeyAndVisible()
    }
  }
  
}

