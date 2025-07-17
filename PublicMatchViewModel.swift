//
//  PublicMatchViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/24/24.
//

import Foundation

class PublicMatchViewModel: ObservableObject {
    @Published var matches: [PublicMatch] = []

    func fetchPublicMatches() {
        let url = URL(string: "https://api.opendota.com/api/publicMatches")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching matches: \(error)")
                return
            }
            guard let data = data else { return }
            do {
                
                self.matches = try JSONDecoder().decode([PublicMatch].self, from: data)
                DispatchQueue.main.async {
                    self.matches = self.matches.map {
                        PublicMatch(matchId: $0.matchId, radiantWin: $0.radiantWin, duration: $0.duration, avgRankTier: $0.avgRankTier, startTime: $0.startTime)
                    }
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
}

