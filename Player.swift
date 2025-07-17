//
//  Player.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/21/24.
//

import Foundation

struct Player: Identifiable, Codable {
    let account_id: Int?
    let steamid: String?
    let avatarfull: String?
    let name: String?
    let country_code: String?
    let team_id: Int?
    let team_name: String?
    let team_tag: String?
    
    var id: Int {
        return account_id ?? 0
    }
    
    var fullCountryName: String {
        if let code = country_code, !code.isEmpty {
            return Locale.current.localizedString(forRegionCode: code.uppercased()) ?? code
        } else {
            return "Unknown"
        }
    }
}


