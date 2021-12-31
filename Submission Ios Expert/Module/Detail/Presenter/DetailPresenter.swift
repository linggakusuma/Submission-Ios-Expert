//
//  DetailPresenter.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import Combine

class DetailPresenter: ObservableObject {
    
    private let detailUseCase: DetailUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var game: Game?
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetail(){
        loadingState = true
        detailUseCase.getDetail()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { game in
                self.game = game
                print(game)
            })
            .store(in: &cancellables)
    }
    
    func addFavorite(){
        guard let game = self.game else { return }
        detailUseCase.addFavorite(game: game)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    break
                case .finished:
                    break
                }
            },
            receiveValue: { isFavorite in
              self.game?.isFavorite = isFavorite
            })
            .store(in: &cancellables)
        
    }
}
