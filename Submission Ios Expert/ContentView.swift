//
//  ContentView.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import Core
import Game

struct ContentView: View {
    @EnvironmentObject var homePresenter: GetListPresenter<Any, GameModuleModel, Interactor<Any, [GameModuleModel], GetGamesRepository<GetGamesRemoteDataSource, GameTransformer>>>
    
    @EnvironmentObject var favoritePresenter: GetListPresenter<Any, GameModuleModel, Interactor<Any, [GameModuleModel], GetFavoriteGameRepository<GetFavoriteGameLocaleDataSource, GameTransformer>>>
    
    var body: some View {
        TabView {
            HomeView(presenter: homePresenter)
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            FavoriteView(presenter: favoritePresenter)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Favorites")
                }
            AboutView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("About")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
