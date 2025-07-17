//
//  PublicMatchView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/24/24.
//

import SwiftUI

struct PublicMatchView: View {
    @ObservedObject var viewModel = PublicMatchViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.matches) { match in
                HStack {
                    VStack {
                        // Radiant Logo with text "Radiant" above
                        Text("Radiant")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .bold()
                        Image("dota_2_logo_radiant")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text(match.radiantWin ? "Win" : "Lose")
                            .font(.caption)
                            .foregroundColor(match.radiantWin ? .green : .red)
                    }
                    Spacer()
                    
                    VStack {
                        // Duration and Rank of the match
                        Text(match.durationFormatted)
                            .frame(width: 100)
                        
                        Text("Rank: \(match.rank)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                   
                    VStack {
                        // Dire Logo with text "Dire" above
                        Text("Dire")
                            .font(.caption)
                            .foregroundColor(.red)
                            .bold()
                        Image("dota_2_logo_dire")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text(match.radiantWin ? "Lose" : "Win")
                            .font(.caption)
                            .foregroundColor(match.radiantWin ? .red : .green)
                    }
                }
                .font(.title2)
                .padding()
                .background(Color.white) // Make sure the background is white for clarity
                .cornerRadius(10)
                .padding(.top, 10)
                .shadow(radius: 10)
            }
            .navigationTitle("Public Matches")
            .onAppear {
                viewModel.fetchPublicMatches()
            }
        }
    }
}




