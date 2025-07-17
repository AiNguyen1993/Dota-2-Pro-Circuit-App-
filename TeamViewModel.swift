//
//  TeamViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import Foundation
import Combine

class TeamViewModel: ObservableObject {
    @Published var teams: [Team] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTeams() {
        guard let url = URL(string: "https://api.opendota.com/api/teams") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Team].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] teams in
                self?.teams = teams
            }
            .store(in: &cancellables)
    }
    
    func fetchTeamsFromLeague(for leagueId: Int) {
            let urlString = "https://api.opendota.com/api/leagues/\(leagueId)/teams"
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: [Team].self, decoder: JSONDecoder())
                .replaceError(with: [])
                .receive(on: DispatchQueue.main)
                .sink { [weak self] teams in
                    self?.teams = teams
                }
                .store(in: &cancellables)
        }
}

class TeamDetailViewModel: ObservableObject {
    @Published var players: [TeamPlayer] = []

    func fetchTeamPlayers(teamId: Int) {
        let urlString = "https://api.opendota.com/api/teams/\(teamId)/players"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedPlayers = try? JSONDecoder().decode([TeamPlayer].self, from: data) {
                    DispatchQueue.main.async {
                        self.players = decodedPlayers.filter { $0.is_current_team_member == true }
                    }
                }
            }
        }.resume()
    }
}
