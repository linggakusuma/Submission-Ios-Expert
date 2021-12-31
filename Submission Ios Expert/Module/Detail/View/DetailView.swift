//
//  DetailView.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @ObservedObject var presenter: DetailPresenter
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
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
        }.navigationBarTitle(Text(self.presenter.game?.name ?? ""), displayMode: .large).onAppear{presenter.getDetail() }
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
            WebImage(url: URL(string: self.presenter.game?.backgroundImage ?? ""))
                .resizable()
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: 350.0, alignment: .center)
            
          
          Button(action: {
            self.presenter.addFavorite()
          }) {
            VStack {
              Image(systemName: self.presenter.game?.isFavorite ?? false ? "heart.fill" : "heart")
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
        Text(self.presenter.game?.description ?? "")
            .font(.system(size: 15)).padding([.leading, .trailing])
    }
    
    func headerTitle(_ title: String) -> some View {
        return Text(title)
            .font(.headline)
    }
    
    var release: some View {
        HStack {
            Text(self.presenter.game?.released ?? "").font(.system(size: 15)).padding([.leading, .trailing]).frame(alignment: .leading)
            spacer
            Label(String(presenter.game?.rating ?? 0.0), systemImage: "star.fill").font(.system(size: 15)).padding([.leading, .trailing]).frame(alignment: .leading)
            
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

