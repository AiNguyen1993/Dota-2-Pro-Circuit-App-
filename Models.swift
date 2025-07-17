//
//  Models.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Phong Nguyen on 12/5/24.
//

import Foundation

struct PlayerInfo {
    let accountID: Int
    let personaName: String
    let steamID: String
    let avatarMedium: String
    let profileURL: String
    let countryCode: String?
    let countryName: String?
    let rankTier: Int
    
    var rankName: String {
        switch rankTier {
        case 10..<20: return "Herald"
        case 20..<30: return "Guardian"
        case 30..<40: return "Crusader"
        case 40..<50: return "Archon"
        case 50..<60: return "Legend"
        case 60..<70: return "Ancient"
        case 70..<80: return "Divine"
        case 80..<90: return "Immortal"
        default: return "Unranked"
        }
    }
}

struct WinLoss: Decodable {
    let win: Int
    let lose: Int
}

struct MatchInfo {
    let matchID: Int
    let radiantWin: Bool
    let duration: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let averageRankName: String
    let xpPerMin: Int
    let goldPerMin: Int
    let towerDamage: Int
    let heroHealing: Int
    let lastHits: Int
}

// Responses for Decoding
struct PlayerInfoResponse: Decodable {
    let profile: Profile
    let rank_tier: Int
    
    struct Profile: Decodable {
        let account_id: Int
        let personaname: String
        let steamid: String
        let avatarmedium: String
        let profileurl: String
        let loccountrycode: String?
    }
    
    func toPlayerInfo() -> PlayerInfo {
        PlayerInfo(
            accountID: profile.account_id,
            personaName: profile.personaname,
            steamID: profile.steamid,
            avatarMedium: profile.avatarmedium,
            profileURL: profile.profileurl,
            countryCode: profile.loccountrycode,
            countryName: Locale.current.localizedString(forRegionCode: profile.loccountrycode ?? ""),
            rankTier: rank_tier
        )
    }
}

struct MatchResponse: Decodable {
    let match_id: Int
    let radiant_win: Bool
    let duration: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let average_rank: Int
    let xp_per_min: Int
    let gold_per_min: Int
    let tower_damage: Int
    let hero_healing: Int
    let last_hits: Int
    
    var matchRankName: String {
        switch average_rank {
        case 10..<20: return "Herald"
        case 20..<30: return "Guardian"
        case 30..<40: return "Crusader"
        case 40..<50: return "Archon"
        case 50..<60: return "Legend"
        case 60..<70: return "Ancient"
        case 70..<80: return "Divine"
        case 80..<90: return "Immortal"
        default: return "Unranked"
        }
    }
    
    func toMatchInfo() -> MatchInfo {
        MatchInfo(
            matchID: match_id,
            radiantWin: radiant_win,
            duration: duration / 60,
            kills: kills,
            deaths: deaths,
            assists: assists,
            averageRankName: "\(matchRankName)",
            xpPerMin: xp_per_min,
            goldPerMin: gold_per_min,
            towerDamage: tower_damage,
            heroHealing: hero_healing,
            lastHits: last_hits
        )
    }
}
