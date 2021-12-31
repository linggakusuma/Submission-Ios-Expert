//
//  AboutView.swift
//  Submission Ios Expert
//
//  Created by Lingga Kusuma Sakti on 13/09/21.
//

import SwiftUI


struct AboutView: View {
    
    var body: some View {
        VStack {
            Image("profile")
                .resizable()
                .clipShape(Circle())
                .shadow(radius: 10)
                .overlay(Circle().stroke(Color.blue.opacity(0.5), lineWidth: 5))
                .padding()
                .frame(width: 200, height: 200, alignment: .center)
            Text("Lingga Kusuma Sakti")
                .font(.title3)
                .bold()
        }
    }
}
