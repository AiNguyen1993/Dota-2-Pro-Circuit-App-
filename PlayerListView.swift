//
//  PlayerListView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/21/24.
//

import SwiftUI

struct PlayerListView: View {
    let players: [Player]

    var body: some View {
        List(players) { player in
            NavigationLink(destination: PlayerDetailView(player: player)) {
                HStack {
                    if let avatarUrl = player.avatarfull, !avatarUrl.isEmpty {
                        AsyncImage(url: URL(string: avatarUrl)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(8)
                            .foregroundColor(.gray)
                    }

                    VStack(alignment: .leading) {
                        Text(player.name ?? "Unknown Player")
                        Text(player.team_name ?? "No Team")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
//        .navigationTitle("Pro Players")
    }
}


