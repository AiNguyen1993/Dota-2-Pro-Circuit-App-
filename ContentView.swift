//
//  ContentView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/21/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var playerViewModel = PlayerViewModel()
    @StateObject var teamViewModel = TeamViewModel()
    @StateObject var leagueViewModel = LeagueViewModel()
    @State private var selectedView = "Leagues"
    @State private var selectedGame = "Quiz"
    @State private var selectedMatchView = "Public Matches"

    var body: some View {
        TabView {
            // Dota2LookupView Tab
            Dota2LookupView()
                .tabItem {
                    Image(systemName: "eye")
                    Text("Home")
                }
            
            // News View Tab
            NewsView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                    Text("News")
                }

            // Public Matches & Hero List combined with Picker
            NavigationView {
                VStack {
                    Text("Matches & Heroes")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)

                    Picker("Select View", selection: $selectedMatchView) {
                        Text("Public Matches").tag("Public Matches")
                        Text("Heroes").tag("Heroes")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    if selectedMatchView == "Public Matches" {
                        PublicMatchView()
                    } else {
                        HeroListView()
                    }
                    
                    Spacer()
                }
//                .navigationTitle("Dota 2 Matches & Heroes")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Refresh action or additional feature
                        }) {
                            Image(systemName: "arrow.clockwise.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .tabItem {
                Label("Matches & Heroes", systemImage: "shield")
            }

            // Dota 2 Pro Circuit Section
            NavigationView {
                VStack {
                    Text("Dota 2 Pro Circuit")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)

                    Picker("", selection: $selectedView) {
                        Text("Leagues").tag("Leagues")
                        Text("Teams").tag("Teams")
                        Text("Players").tag("Players")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    if selectedView == "Leagues" {
                        LeagueListView()
                    } else if selectedView == "Teams" {
                        if teamViewModel.teams.isEmpty {
                            Text("Loading teams...")
                                .onAppear {
                                    teamViewModel.fetchTeams()
                                }
                        } else {
                            TeamListView(teams: teamViewModel.teams)
                        }
                    } else {
                        if playerViewModel.players.isEmpty {
                            Text("Loading players...")
                                .onAppear {
                                    playerViewModel.fetchPlayers()
                                }
                        } else {
                            PlayerListView(players: playerViewModel.players)
                        }
                    }
                }
//                .navigationTitle("Pro Circuit")
                .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Professionals", systemImage: "trophy.fill")
            }

            // Game Modes Tab
            NavigationView {
                VStack {
                    Text("Dota 2 Game Modes")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)

                    Picker("", selection: $selectedGame) {
                        Text("Quiz").tag("Quiz")
                        Text("Guess Hero").tag("GuessHero")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    if selectedGame == "Quiz" {
                        QuizView()
                    } else {
                        GuessHeroView()
                    }
                    
                    Spacer()
                }
            }
            .tabItem {
                Label("Game Modes", systemImage: "gamecontroller.fill")
            }
        }
        .accentColor(.blue)
        .onAppear {

        }
    }
}






#Preview {
    ContentView()
}
