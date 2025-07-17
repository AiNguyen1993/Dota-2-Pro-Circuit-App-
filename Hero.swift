//
//  Hero.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import Foundation

struct Hero: Identifiable, Codable {
    let id: Int
    let localized_name: String
    let primary_attr: String
    let attack_type: String
    let roles: [String]
 
}

struct Matchup: Codable {
    let hero_id: Int
    let games_played: Int
    let wins: Int
}

struct TopPlayer: Identifiable, Codable {
    let account_id: Int
    let games_played: Int
    let wins: Int

    var id: Int {
        return account_id
    }
}

