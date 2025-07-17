//
//  TeamDetailView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import SwiftUI

struct TeamDetailView: View {
    var team: Team
    @ObservedObject var teamDetailViewModel = TeamDetailViewModel()
    @ObservedObject var playerViewModel = PlayerViewModel()

    var body: some View {
        VStack(alignment: .leading) {
//            Text(team.name)
//                .font(.largeTitle)
//                .padding()

            Text("Wins: \(team.wins), Losses: \(team.losses)")
                .padding(.bottom)

            Text("Players")
                .font(.headline)
                .padding(.vertical)

            if teamDetailViewModel.players.isEmpty {
                Text("No players found")
            } else {
                List(teamDetailViewModel.players) { player in
                    NavigationLink(destination: {
                        if let fullPlayer = findPlayerByAccountId(accountId: player.account_id) {
                            PlayerDetailView(player: fullPlayer)
                        } else {
                            PlayerDetailView(player: convertTeamPlayerToPlayer(teamPlayer: player))
                        }
                    }) {
                        VStack(alignment: .leading) {
                            Text(player.name ?? "Unknown Player")
                                .font(.headline)
                            Text("Games Played: \(player.games_played), Wins: \(player.wins)")
                                .font(.subheadline)
                        }
                    }
                }
            }
        }
        .navigationTitle(team.name)
        .onAppear {
            teamDetailViewModel.fetchTeamPlayers(teamId: team.team_id)
            playerViewModel.fetchPlayers()
        }
    }

   
    func convertTeamPlayerToPlayer(teamPlayer: TeamPlayer) -> Player {
        return Player(
            account_id: teamPlayer.account_id,
            steamid: nil,
            avatarfull: nil,
            name: teamPlayer.name,
            country_code: nil,
            team_id: nil,
            team_name: team.name,
            team_tag: nil
        )
    }

    // Helper function to find a player in PlayerViewModel by account ID
    func findPlayerByAccountId(accountId: Int?) -> Player? {
        guard let accountId = accountId else { return nil }
        return playerViewModel.players.first { $0.account_id == accountId }
    }
}



