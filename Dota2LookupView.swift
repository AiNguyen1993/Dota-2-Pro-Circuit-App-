//
//  Dota2LookupView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Phong Nguyen on 12/5/24.
//

import SwiftUI

struct Dota2LookupView: View {
    @State private var accountID: String = ""
    @State private var playerInfo: PlayerInfo?
    @State private var recentMatches: [MatchInfo] = []
    @State private var winRate: Double?
    @State private var errorMessage: String?
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                // Title
                
                Text("Please ignore this but use id: 114417744 to test this view")
                
                Text("Dota 2 Player Lookup")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                
                // Input field for account ID
                HStack {
                    TextField("Enter your Dota 2 ID", text: $accountID)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                        .keyboardType(.numberPad)
                        .padding(.horizontal)
                        .shadow(radius: 5)
                    
                    
                    // Fetch button
                    Button(action: fetchPlayerData) {
                        Text("Lookup")
//                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                }
                // Error message if there's an issue
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                // If player info is available
                if let playerInfo = playerInfo {
                    VStack {
                        // General Info View
                        GeneralInfoView(playerInfo: playerInfo, winRate: winRate)
                            .padding(.horizontal)
                        
                        // Recent Matches
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                if !recentMatches.isEmpty {
                                    Text("Recent Matches")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.top)
                                    
                                    ForEach(recentMatches, id: \.matchID) { match in
                                        MatchView(match: match)
                                            .padding(.bottom)
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .padding()
    }
    
    private func fetchPlayerData() {
        guard let accountID = Int(accountID) else {
            errorMessage = "Invalid Account ID"
            return
        }
        
        Task {
            do {
                errorMessage = nil
                let playerInfo = try await APIManager.fetchPlayerInfo(accountID: accountID)
                let winLoss = try await APIManager.fetchWinLoss(accountID: accountID)
                let matches = try await APIManager.fetchRecentMatches(accountID: accountID)
                
                self.playerInfo = playerInfo
                self.winRate = Double(winLoss.win) / Double(winLoss.win + winLoss.lose)
                self.recentMatches = matches.prefix(5).map { $0 }
            } catch {
                errorMessage = "Unable to fetch player data. Please check the Account ID."
            }
        }
    }
}

struct Dota2LookupView_Previews: PreviewProvider {
    static var previews: some View {
        Dota2LookupView()
            .previewLayout(.sizeThatFits)
    }
}


