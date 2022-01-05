//
//  HomeRouter.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import Game
import Core

class HomeRouter {
  func makeDetailView(for game: GameModuleModel) -> some View {
    let detailUseCase: Interactor<Int32,GameModuleModel, GetDetailGameRepository<GetGameLocaleDataSource,GetDetailGameDataSource, DetailGameTransformer>> = Injection.init().provideDetailGame()
    let favoriteUseCase: Interactor<GameModuleModel, Bool, AddFavoriteGameRepository<AddGameLocaleDataSource, AddFavoriteGameTransformer>> = Injection.init().provideAddFavoriteGame()
    let presenter = DetailGamePresenter(detailGameUseCase: detailUseCase, favoriteUseCase: favoriteUseCase)
    return DetailView(presenter: presenter, game: game)
  }
}
