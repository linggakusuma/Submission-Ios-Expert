//
//  HomeView.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        NavigationView {
            ZStack {
                if presenter.loadingState {
                    VStack {
                        Text("Loading...")
                        ActivityIndicator()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(
                            self.presenter.games,
                            id: \.id
                        ) { game in
                            ZStack {
                                self.presenter.linkBuilder(for: game) {
                                    GameRow(game: game)
                                }.buttonStyle(PlainButtonStyle())
                            }.padding(8)
                            
                        }
                    }
                }
            }.onAppear {
                if self.presenter.games.count == 0 {
                    self.presenter.getGames()
                }
            }.navigationBarTitle(
                Text("Games Apps"),
                displayMode: .automatic
            )
        }
    }
    
}
