//
//  PlayerViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/21/24.
//

import Foundation
import Combine

class PlayerViewModel: ObservableObject {
    @Published var players: [Player] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPlayers() {
        guard let url = URL(string: "https://api.opendota.com/api/proPlayers") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Player].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching players: \(error)")
                }
            }, receiveValue: { [weak self] players in
                self?.players = players.filter { $0.account_id != nil }
                print("Players fetched: \(self?.players.count ?? 0)") 
            })
            .store(in: &cancellables)
    }
}

