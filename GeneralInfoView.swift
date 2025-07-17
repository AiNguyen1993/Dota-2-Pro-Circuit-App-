//
//  GeneralInfoView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Phong Nguyen on 12/5/24.
//

import SwiftUI

struct GeneralInfoView: View {
    let playerInfo: PlayerInfo
    let winRate: Double?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                AsyncImage(url: URL(string: playerInfo.avatarMedium)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text("Player: \(playerInfo.personaName)")
                        .font(.headline)
                    Text("Steam ID: \(playerInfo.steamID)")
                    if let profileURL = URL(string: playerInfo.profileURL) {
                        Link("View Profile", destination: profileURL)
                    }
                }
            }
            Text("Country: \(playerInfo.countryName ?? playerInfo.countryCode ?? "Unknown")")
            Text("Rank: \(playerInfo.rankName)")
            if let winRate = winRate {
                Text("Winrate: \(String(format: "%.2f%%", winRate * 100))")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}
