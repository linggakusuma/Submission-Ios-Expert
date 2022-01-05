//
//  HomeView.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import Core
import Game

struct HomeView: View {
  
  @ObservedObject var presenter: GetListPresenter<Any, GameModuleModel, Interactor<Any, [GameModuleModel], GetGamesRepository<GetGamesRemoteDataSource, GameTransformer>>>
  
  var body: some View {
    NavigationView {
      ZStack {
        if presenter.isLoading {
          VStack {
            Text("Loading...")
            ActivityIndicator()
          }
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.list,
              id: \.id
            ) { game in
              ZStack {
                linkBuilder(for: game) {
                  GameRow(game: game)
                }.buttonStyle(PlainButtonStyle())
                
              }.padding(8)
              
            }
          }
        }
      }.onAppear {
        if self.presenter.list.count == 0 {
          self.presenter.getList(request: nil)
        }
      }.navigationBarTitle(
        Text("Games Apps"),
        displayMode: .automatic
      )
    }
  }
  
  func linkBuilder<Content: View>(
    for game: GameModuleModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    
    NavigationLink(
      destination: HomeRouter().makeDetailView(for: game)
    ) { content() }
  }
}
