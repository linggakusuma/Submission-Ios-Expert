//
//  GameRow.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 12/09/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Game
import Core

struct GameRow: View {
    
    var game: GameModuleModel
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
