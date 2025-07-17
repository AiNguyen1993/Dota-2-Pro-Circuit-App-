//
//  HeroListView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import SwiftUI

struct HeroListView: View {
    @ObservedObject var heroViewModel = HeroViewModel()
    @ObservedObject var playerViewModel = PlayerViewModel()

    var body: some View {
        NavigationView {
            List(heroViewModel.heroes) { hero in
                NavigationLink(destination: HeroDetailView(hero: hero)
                                .environmentObject(heroViewModel)
                                .environmentObject(playerViewModel)) {
                    HStack {
                        // Dota 2 Logo before the hero name
                        Image("dota_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding(.trailing, 10)
                        
                        VStack(alignment: .leading) {
                            Text(hero.localized_name)
                                .font(.headline)
                            Text("Primary Attribute: \(hero.primary_attr.capitalized)")
                            Text("Attack Type: \(hero.attack_type)")
                        }
                    }
                }
            }
            .navigationTitle("Dota 2 Heroes")
            .onAppear {
                heroViewModel.fetchHeroes()
                playerViewModel.fetchPlayers()
            }
        }
    }
}




