//
//  PlayerProfileViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/23/24.
//

import Foundation
import Combine

class PlayerProfileViewModel: ObservableObject {
    @Published var playerProfile: PlayerProfile? 
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPlayerProfile(for accountId: Int) {
        guard let url = URL(string: "https://api.opendota.com/api/players/\(accountId)") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: PlayerProfile.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching player profile: \(error)")
                }
            }, receiveValue: { [weak self] playerProfile in
                self?.playerProfile = playerProfile
                print("Player profile fetched: \(playerProfile.personaname)")
            })
            .store(in: &cancellables)
    }
}


