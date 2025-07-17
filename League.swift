//
//  League.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import Foundation

struct League: Identifiable, Codable {
    let id: Int // leagueid
    let tier: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id = "leagueid"
        case tier
        case name
    }
}

struct LeagueTeam: Identifiable, Codable {
    let id: Int // team_id
    let rating: Double
    let wins: Int
    let losses: Int
    let name: String
    let tag: String?
    let logo_url: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "team_id"
        case rating
        case wins
        case losses
        case name
        case tag
        case logo_url
    }
}
