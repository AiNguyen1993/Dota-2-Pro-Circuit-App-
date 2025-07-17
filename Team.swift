//
//  Team.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

struct Team: Identifiable, Codable {
    let team_id: Int
    let name: String
    let tag: String
    let wins: Int
    let losses: Int
    let rating: Double
    let logo_url: String?

    var id: Int {
        return team_id
    }
}

struct TeamPlayer: Identifiable, Codable {
    let account_id: Int
    let name: String?
    let games_played: Int
    let wins: Int
    let is_current_team_member: Bool?

    var id: Int {
        return account_id
    }
}
