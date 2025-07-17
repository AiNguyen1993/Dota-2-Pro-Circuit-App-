//
//  PlayerDetailView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/21/24.
//

import SwiftUI

struct PlayerDetailView: View {
    let player: Player

    var body: some View {
        VStack {
            if let avatarUrl = player.avatarfull, !avatarUrl.isEmpty {
                AsyncImage(url: URL(string: avatarUrl)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
            }

            Text(player.name ?? "Unknown Player")
                .font(.title)

            Text("Team: \(player.team_name ?? "No Team")")
            Text("Country: \(player.fullCountryName)")
            Text("Steam ID: \(player.steamid ?? "No Steam ID")")
//            Text("Account ID: \(player.account_id != nil ? String(player.account_id) : "No Account ID")")
        }
        .padding()
    }
}
