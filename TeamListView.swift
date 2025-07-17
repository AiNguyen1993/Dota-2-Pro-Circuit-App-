//
//  TeamDetailView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import SwiftUI

struct TeamListView: View {
    let teams: [Team]

    var body: some View {
        List(teams) { team in
            NavigationLink(destination: TeamDetailView(team: team)) {
                HStack {
                    if let logoUrl = team.logo_url, !logoUrl.isEmpty {
                        AsyncImage(url: URL(string: logoUrl)) { image in
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
                        Text(team.name.isEmpty ? "Unknown Team" : team.name)
                            .font(.headline)
                        Text("Wins: \(team.wins), Losses: \(team.losses)")
                            .font(.subheadline)
                    }
                }
            }
        }
//        .navigationTitle("Teams")
    }
}

