//
//  LeagueDetailView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import SwiftUI

struct LeagueDetailView: View {
    let leagueId: Int
    @State private var leagueTeams: [LeagueTeam] = []
    @State private var allTeams: [Team] = []
    @State private var isLoading = true
    @StateObject private var teamViewModel = TeamViewModel()

    var body: some View {
        List(leagueTeams) { leagueTeam in
            NavigationLink(destination: TeamDetailView(team: findTeamById(teamId: leagueTeam.id))) {
                HStack {
                    if let logoUrl = leagueTeam.logo_url, let url = URL(string: logoUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(leagueTeam.name)
                            .font(.headline)
                        Text(leagueTeam.tag ?? "")
                            .font(.subheadline)
                    }
                }
            }
        }
        .navigationTitle("League Teams")
        .onAppear {
            fetchLeagueTeams()
            fetchAllTeams()
        }
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
    }

    private func fetchLeagueTeams() {
        let viewModel = LeagueViewModel()
        viewModel.fetchTeams(for: leagueId) { fetchedTeams in
            if let fetchedTeams = fetchedTeams {
                self.leagueTeams = fetchedTeams
            }
            self.isLoading = false
        }
    }

    private func fetchAllTeams() {
        teamViewModel.fetchTeams()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.allTeams = teamViewModel.teams
        }
    }

    
    private func findTeamById(teamId: Int) -> Team {
            if let foundTeam = allTeams.first(where: { $0.team_id == teamId }) {
                return Team(
                    team_id: foundTeam.team_id,
                    name: foundTeam.name,
                    tag: foundTeam.tag,
                    wins: foundTeam.wins,
                    losses: foundTeam.losses,
                    rating: foundTeam.rating,
                    logo_url: foundTeam.logo_url
                )
            }
            return Team(team_id: 0, name: "Unknown Team", tag: "", wins: 0, losses: 0, rating: 0.0, logo_url: nil)
        }
}



