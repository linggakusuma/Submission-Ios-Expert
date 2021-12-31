//
//  GameRow.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameRow: View {
    
    var game: Game
    var body: some View {
        VStack {
            imageCategory
            content
        }
        .frame(width: UIScreen.main.bounds.width - 16, height: 350)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(30)
    }
    
}

extension GameRow {
    
    var imageCategory: some View {
        WebImage(url: URL(string: game.backgroundImage))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .cornerRadius(30)
        
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(game.name)
                .font(.title)
                .bold()
            
            Text(game.released)
                .font(.system(size: 14))
                .lineLimit(2)
        }.padding(
            EdgeInsets(
                top: 0,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        )
    }
    
}

struct GameRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let game = Game(id: 1, name: "GTA V", released: "10 Jun 2000", backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg", rating: 5.0, description: "", isFavorite: false)
        return GameRow(game: game)
    }
    
}
