//
//  HomeRouter.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI

class HomeRouter {
    func makeDetailView(for game: Game) -> some View {
        let detailUseCase = Injection.init().provideDetail(id: game.id)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailView(presenter: presenter)
    }
}
