//
//  FavoriteFile.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 13/09/21.
//

import SwiftUI

struct FavoriteView : View {
  
  @ObservedObject var presenter: FavoritePresenter
  
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
                Text(self.presenter.emptyMessage)
                  .font(.title3)
                  .bold()
                  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                self.presenter.linkBuilder(for: game) {
                  GameRow(game: game)
                }.buttonStyle(PlainButtonStyle())
              }.padding(8)
              
            }
          }
        }
      }.onAppear {
        self.presenter.getFavorites()
      }.navigationBarTitle(
        Text("Favorite Games"),
        displayMode: .automatic
      )
    }
  }
}

