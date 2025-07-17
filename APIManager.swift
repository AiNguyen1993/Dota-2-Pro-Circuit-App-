//
//  APIManager.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Phong Nguyen on 12/5/24.
//

import Foundation

struct APIManager {
    static func fetchPlayerInfo(accountID: Int) async throws -> PlayerInfo {
        let url = URL(string: "https://api.opendota.com/api/players/\(accountID)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(PlayerInfoResponse.self, from: data)
        return response.toPlayerInfo()
    }
    
    static func fetchWinLoss(accountID: Int) async throws -> WinLoss {
        let url = URL(string: "https://api.opendota.com/api/players/\(accountID)/wl")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WinLoss.self, from: data)
    }
    
    static func fetchRecentMatches(accountID: Int) async throws -> [MatchInfo] {
        let url = URL(string: "https://api.opendota.com/api/players/\(accountID)/recentMatches")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let matches = try JSONDecoder().decode([MatchResponse].self, from: data)
        return matches.map { $0.toMatchInfo() }
    }
}


