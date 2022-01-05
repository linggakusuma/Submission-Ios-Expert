//
//  FavoriteFile.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 13/09/21.
//

import SwiftUI
import Core
import Game

struct FavoriteView : View {
  
  @ObservedObject var presenter: GetListPresenter<Any, GameModuleModel, Interactor<Any, [GameModuleModel], GetFavoriteGameRepository<GetFavoriteGameLocaleDataSource, GameTransformer>>>
  
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
                Text(self.presenter.errorMessage)
                  .font(.title3)
                  .bold()
                  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                linkBuilder(for: game) {
                  GameRow(game: game)
                }.buttonStyle(PlainButtonStyle())
              }.padding(8)
              
            }
          }
        }
      }.onAppear {
        self.presenter.getList(request: nil)
      }.navigationBarTitle(
        Text("Favorite Games"),
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

