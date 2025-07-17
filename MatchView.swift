//
//  MatchView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Phong Nguyen on 12/5/24.
//

import SwiftUI

struct MatchView: View {
    let match: MatchInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Match ID and Result (Use HStack for side-by-side layout)
            HStack {
                Text("Match ID: \(match.matchID)")
                    .fontWeight(.bold)
                Spacer()
                Text("Result: \(match.radiantWin ? "Win" : "Loss")")
                    .foregroundColor(match.radiantWin ? .green : .red)
            }
            
            // Duration and Kills/Deaths/Assists (2 columns)
            HStack {
                VStack(alignment: .leading) {
                    Text("Duration: \(match.duration) minutes")
                    Text("K/D/A: \(match.kills)/\(match.deaths)/\(match.assists)")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Match Rank: \(match.averageRankName)")
                    Text("XP per Minute: \(match.xpPerMin)")
                }
            }
            
            // Gold per Minute, Tower Damage, Hero Healing (3 columns)
            HStack {
                VStack(alignment: .leading) {
                    Text("Gold per Minute: \(match.goldPerMin)")
                    Text("Tower Damage: \(match.towerDamage)")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Hero Healing: \(match.heroHealing)")
                    Text("Last Hits: \(match.lastHits)")
                }
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
        .frame(maxWidth: .infinity) // Full width
        .padding(.horizontal)
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        // Example preview with mock data
        MatchView(match: MatchInfo(
            matchID: 8063593292,
            radiantWin: true,
            duration: 40,
            kills: 5,
            deaths: 3,
            assists: 12,
            averageRankName: "Crusader",
            xpPerMin: 674,
            goldPerMin: 433,
            towerDamage: 1534,
            heroHealing: 195,
            lastHits: 76
        ))
        .previewLayout(.sizeThatFits)
    }
}
