//
//  HeroDetailView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import SwiftUI


struct HeroDetailView: View {
    var hero: Hero
    @EnvironmentObject var heroViewModel: HeroViewModel
    @StateObject var playerProfileViewModel = PlayerProfileViewModel() // Use StateObject for ViewModel

    var body: some View {
        VStack {
            Spacer()
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Spacer()
                    // Matchups section with a stylish design
                    Text("Most Common Matchups")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    ForEach(heroViewModel.matchups, id: \.hero_id) { matchup in
                        if let matchedHero = heroViewModel.heroes.first(where: { $0.id == matchup.hero_id }) {
                            HStack {
                                Image("dota_logo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35)
                                    .padding(.trailing, 12)
                                
                                VStack(alignment: .leading) {
                                    
                                    Text("Hero: \(matchedHero.localized_name)")
                                        .font(.headline)
                                        .foregroundColor(.blue)
                                    
                                    Text("Games Played: \(matchup.games_played), Wins: \(matchup.wins)")
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                    }
                    
                    // Top Players section with the cool layout
                    Text("Top Players")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.top, 10)
                    
                    ForEach(heroViewModel.topPlayers.prefix(5), id: \.account_id) { player in
                        HStack {
                            Image("dota_logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .padding(.trailing, 10)
                            
                            Text("Account ID: \(player.account_id), Games Played: \(player.games_played), Wins: \(player.wins)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.bottom, 8)
                    }
                }
                .padding()
                .onAppear {
                    heroViewModel.fetchMatchups(for: hero.id)
                    heroViewModel.fetchTopPlayers(for: hero.id)
                }
            }
            //        .navigationTitle(hero.localized_name)
        }
        .background(Color("BackgroundColor"))
        .edgesIgnoringSafeArea(.all)
    }
}




