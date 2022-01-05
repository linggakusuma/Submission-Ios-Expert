//
//  File.swift
//  
//
//  Created by Lingga Kusuma Sakti on 05/01/22.
//

import SwiftUI
import Combine
import Core

public class DetailGamePresenter<DetailGameUseCase: UseCase, FavoriteUseCase: UseCase>: ObservableObject
where
DetailGameUseCase.Request == Int32,
DetailGameUseCase.Response == GameModuleModel,
FavoriteUseCase.Request == GameModuleModel,
FavoriteUseCase.Response == Bool {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let _detailGameUseCase: DetailGameUseCase
  private let _favoriteUseCase: FavoriteUseCase
  
  @Published public var data: GameModuleModel?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  
  public init(detailGameUseCase: DetailGameUseCase, favoriteUseCase: FavoriteUseCase) {
    _detailGameUseCase = detailGameUseCase
    _favoriteUseCase = favoriteUseCase
  }
  
  public func getData(request: DetailGameUseCase.Request) {
    isLoading = true
    _detailGameUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { data in
        self.data = data
      }).store(in: &cancellables)
  }
  
  public func addFavorite(request: FavoriteUseCase.Request) {
    _favoriteUseCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          break
        case .finished:
          break
        }
        
      }, receiveValue: { isFavorite in
        self.data?.isFavorite = isFavorite
      }).store(in: &cancellables)
  }
}
