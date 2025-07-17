//
//  LeagueListView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import SwiftUI

struct LeagueListView: View {
    @ObservedObject var viewModel = LeagueViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.leagues) { league in
                NavigationLink(destination: LeagueDetailView(leagueId: league.id)) {
                    VStack(alignment: .leading) {
                        Text(league.name)
                            .font(.headline)
                    }
                }
            }
//            .navigationTitle("Leagues")
            .onAppear {
                viewModel.fetchLeagues() 
            }
        }
    }
}

//struct LeagueListView: View {
//    @StateObject var viewModel = LeagueViewModel()
//
//    var body: some View {
//        NavigationView {
//            List(viewModel.leagues) { league in
//                NavigationLink(destination: LeagueDetailView(leagueId: league.id)) {
//                    Text(league.name)
//                }
//            }
//            .navigationTitle("Leagues")
//            .onAppear {
//                viewModel.fetchLeagues()
//            }
//        }
//    }
//}

