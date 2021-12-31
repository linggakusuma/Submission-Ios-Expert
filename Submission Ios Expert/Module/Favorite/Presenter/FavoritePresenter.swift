//
//  FavoritePresenter.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 14/09/21.
//

import SwiftUI
import Combine
import RealmSwift

class FavoritePresenter : ObservableObject {
  
  private let favoriteUseCase: FavoriteUseCase
  private let router = HomeRouter()
  private var cancellables: Set<AnyCancellable> = []
  
  @Published var games: [Game] = []
  @Published var loadingState: Bool = false
  @Published var errorMessage: String = ""
  @Published var emptyMessage: String = ""
  
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getFavorites(){
    loadingState = true
    favoriteUseCase.getFavorites()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
          
        }
      }, receiveValue: { games in
        if games.isEmpty {
          self.emptyMessage = "Not found favorite games"
        } else {
          self.games = games
        }
      })
      .store(in: &cancellables)
  }
  
  func linkBuilder<Content: View>(for game: Game, @ViewBuilder content: () -> Content) -> some View {
    NavigationLink(
      destination: router.makeDetailView(for: game)) {content()}
  }
}
