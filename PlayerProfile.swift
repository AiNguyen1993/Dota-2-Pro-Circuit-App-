//
//  PlayerProfile.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import Foundation

struct PlayerProfile: Identifiable, Codable {
    let account_id: Int
    let personaname: String
    let avatarfull: String
    let loccountrycode: String

    var id: Int {
        return account_id
    }

    var fullCountryName: String {
        if let countryName = Locale.current.localizedString(forRegionCode: loccountrycode) {
            return countryName
        }
        return "Unknown"
    }
}


