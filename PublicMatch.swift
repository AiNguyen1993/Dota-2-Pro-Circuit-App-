//
//  PublicMatch.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Phong Nguyen on 10/24/24.
//

import Foundation

struct PublicMatch: Identifiable, Codable {
    var id: Int { matchId }
    let matchId: Int
    let radiantWin: Bool
    let duration: Int
    let avgRankTier: Int
    
    let startTime: Int?

    enum CodingKeys: String, CodingKey {
        case matchId = "match_id"
        case radiantWin = "radiant_win"
        case duration
        case avgRankTier = "avg_rank_tier"
        case startTime = "start_time" 
    }
    
    var durationFormatted: String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = duration % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    var rank: String {
            switch avgRankTier {
            case 10..<20:
                return "Herald"
            case 20..<30:
                return "Guardian"
            case 30..<40:
                return "Crusader"
            case 40..<50:
                return "Archon"
            case 50..<60:
                return "Legend"
            case 60..<70:
                return "Ancient"
            case 70..<80:
                return "Divine"
            case 80..<90:
                return "Immortal"
            default:
                return "Unranked"
            }
        }
}



