//
//  HeroViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import Foundation



class HeroViewModel: ObservableObject {
    @Published var heroes: [Hero] = []
    @Published var matchups: [Matchup] = []
    @Published var topPlayers: [TopPlayer] = []

    func fetchHeroes() {
        guard let url = URL(string: "https://api.opendota.com/api/heroes") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let fetchedHeroes = try JSONDecoder().decode([Hero].self, from: data)
                DispatchQueue.main.async {
                    self.heroes = fetchedHeroes
                }
            } catch {
                print("Error fetching heroes: \(error)")
            }
        }
        task.resume()
    }

    func fetchMatchups(for heroId: Int) {
        guard let url = URL(string: "https://api.opendota.com/api/heroes/\(heroId)/matchups") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let fetchedMatchups = try JSONDecoder().decode([Matchup].self, from: data)
                DispatchQueue.main.async {
                    self.matchups = Array(fetchedMatchups.prefix(5))
                }
            } catch {
                print("Error fetching matchups: \(error)")
            }
        }
        task.resume()
    }

    // Fetch top players for a specific hero
    func fetchTopPlayers(for heroId: Int) {
        guard let url = URL(string: "https://api.opendota.com/api/heroes/\(heroId)/players") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let fetchedPlayers = try JSONDecoder().decode([TopPlayer].self, from: data)
                DispatchQueue.main.async {
                    self.topPlayers = Array(fetchedPlayers.prefix(5))
                    print("Top players fetched: \(self.topPlayers)") 
                }
            } catch {
                print("Error fetching top players: \(error)")
            }
        }
        task.resume()
    }
}


