//
//  LeagueViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import Foundation
import Combine

class LeagueViewModel: ObservableObject {
    @Published var leagues: [League] = []
    private var cancellables = Set<AnyCancellable>()

    func fetchLeagues() {
        guard let url = URL(string: "https://api.opendota.com/api/leagues") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [League].self, decoder: JSONDecoder())
            .catch { error -> Just<[League]> in
                print("Error fetching leagues: \(error.localizedDescription)")
                print("Error Details: \(error)")
                return Just([])
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] leagues in
//                print("Fetched leagues before filtering: \(leagues)")
                self?.leagues = leagues.filter { $0.tier == "premium" }
//                print("Fetched leagues after filtering: \(self?.leagues ?? [])")
            }
            .store(in: &cancellables)
    }

    func fetchTeams(for leagueId: Int, completion: @escaping ([LeagueTeam]?) -> Void) {
        let urlString = "https://api.opendota.com/api/leagues/\(leagueId)/teams"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedTeams = try? JSONDecoder().decode([LeagueTeam].self, from: data) {
                    DispatchQueue.main.async {
                        completion(decodedTeams)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }

}




