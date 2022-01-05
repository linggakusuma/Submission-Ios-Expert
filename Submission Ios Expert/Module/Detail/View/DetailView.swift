//
//  DetailView.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Game

struct DetailView: View {
  @ObservedObject var presenter: DetailGamePresenter<
    Interactor<Int32, GameModuleModel,GetDetailGameRepository<GetGameLocaleDataSource,GetDetailGameDataSource, DetailGameTransformer>>,
    Interactor<GameModuleModel, Bool, AddFavoriteGameRepository<AddGameLocaleDataSource, AddFavoriteGameTransformer>>
  >
  
  var game: GameModuleModel
  
  var body: some View {
    ZStack {
      if presenter.isLoading {
        loadingIndicator
      } else {
        ScrollView(.vertical) {
          VStack {
            image
            spacer
            release
            spacer
            content
            spacer
          }.padding()
        }
      }
    }.navigationBarTitle(Text(self.game.name), displayMode: .large)
      .onAppear{ presenter.getData(request: self.game.id) }
  }
}

extension DetailView {
  var spacer: some View {
    Spacer()
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  var image: some View {
    ZStack(alignment: .topTrailing) {
      WebImage(url: URL(string: self.presenter.data?.backgroundImage ?? ""))
        .resizable()
        .indicator(.activity)
        .transition(.fade(duration: 0.5))
        .scaledToFit()
        .frame(width: UIScreen.main.bounds.width, height: 350.0, alignment: .center)
      
      
      Button(action: {
        self.presenter.addFavorite(request: game)
      }) {
        VStack {
          Image(systemName: self.presenter.data?.isFavorite ?? false ? "heart.fill" : "heart")
            .resizable()
            .scaledToFit()
            .padding([.leading, .trailing])
            .frame(width: 60.0, height: 60.0, alignment: .trailing)
            .alignmentGuide(.top){$0[.bottom] }
        }
      }
    }
  }
  
  var description: some View {
    Text(self.presenter.data?.description ?? "")
      .font(.system(size: 15)).padding([.leading, .trailing])
  }
  
  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }
  
  var release: some View {
    HStack {
      Text(self.presenter.data?.released ?? "").font(.system(size: 15)).padding([.leading, .trailing]).frame(alignment: .leading)
      spacer
      Label(String(presenter.data?.rating ?? 0.0), systemImage: "star.fill").font(.system(size: 15)).padding([.leading, .trailing]).frame(alignment: .leading)
      
    }
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      headerTitle("Description")
        .padding([.leading, .trailing])
      description
    }
  }
}

