//
//  GuessHeroView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/24/24.
//

import SwiftUI

struct GuessHeroView: View {
    @State private var allHeroes: [HeroQuiz] = []
    @State private var currentHero: HeroQuiz? = nil
    @State private var currentClueIndex: Int = 0
    @State private var userGuess: String = ""
    @State private var score: Int = 0
    @State private var isGameStarted: Bool = false
    @State private var isGameFinished: Bool = false
    @State private var timeRemaining: Int = 60
    @State private var timer: Timer?

    var body: some View {
        VStack {
            if isGameFinished {
                
                VStack {
                    Text("Game Over!")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .padding()
                    
                    Text("You guessed \(score) heroes correctly!")
                        .font(.title)
                        .padding()
                        .transition(.opacity)
                    
                    Button("Play Again") {
                        resetGame()
                    }
                    .frame(maxWidth: .infinity)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.top, 20)
                }
                .transition(.scale)
            } else {
                if isGameStarted {
                    VStack {
                        Text("Guess the Hero!")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                            .padding()
                        
                        Text("Clue: \(currentHero?.clues[currentClueIndex] ?? "")")
                            .font(.headline)
                            .padding()
                            .background(Color.yellow.opacity(0.3))
                            .cornerRadius(12)
                            .shadow(radius: 8)
                        
                        TextField("Type your guess here...", text: $userGuess)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                        
                        Button(action: {
                            checkGuess()
                        }) {
                            Text("Submit Guess")
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                                .shadow(radius: 8)
                        }
                        .padding(.top)
                        
                        Button(action: {
                            nextClue()
                        }) {
                            Text("Next Clue")
                                .frame(maxWidth: .infinity)
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(10)
                                .shadow(radius: 8)
                        }
                        .padding(.top, 10)
                        
                        Text("Time remaining: \(timeRemaining) seconds")
                            .font(.subheadline)
                            .foregroundColor(.red)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .padding(.top)
                    }
                    .transition(.slide)
                } else {
                    VStack(spacing: 20) {
                        Text("Welcome to the Hero Guessing Game!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .padding(.top)
                        
                        Text("You'll get clues about a Dota 2 hero. Try to guess the hero as quickly as you can! You have 60 seconds per game.")
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .padding()
                            .background(Color.yellow.opacity(0.3))
                            .cornerRadius(12)
                            .shadow(radius: 8)
                        
                        Button("Start Game") {
                            startGame()
                        }
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.top, 10)
                        .shadow(radius: 10)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            loadHeroes()
        }
    }

    private func loadHeroes() {
        if let url = Bundle.main.url(forResource: "heroes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                allHeroes = try JSONDecoder().decode([HeroQuiz].self, from: data)
            } catch {
                print("Error loading heroes: \(error)")
            }
        }
    }

    private func startGame() {
        currentHero = allHeroes.randomElement()
        currentClueIndex = 0
        score = 0
        isGameStarted = true
        timeRemaining = 60
        
        // Start the countdown timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isGameFinished = true
                timer?.invalidate()
            }
        }
    }

    private func checkGuess() {
        if let hero = currentHero, userGuess.lowercased() == hero.hero.lowercased() {
            score += 1
            nextHero()
        } else {
            userGuess = ""
        }
    }

    private func nextClue() {
        if currentClueIndex < (currentHero?.clues.count ?? 0) - 1 {
            currentClueIndex += 1
        } else {
            isGameFinished = true
        }
        userGuess = ""
    }

    private func nextHero() {
        if let index = allHeroes.firstIndex(of: currentHero!) {
            if index + 1 < allHeroes.count {
                currentHero = allHeroes[index + 1]
                currentClueIndex = 0
            } else {
                isGameFinished = true
            }
        }
        userGuess = ""
    }

    private func resetGame() {
        isGameFinished = false
        isGameStarted = false
        timer?.invalidate()
    }
}

// HeroQuiz Struct to decode JSON and conform to Equatable
struct HeroQuiz: Identifiable, Codable, Equatable {
    let hero: String
    let clues: [String]

    var id: String { hero }

    static func ==(lhs: HeroQuiz, rhs: HeroQuiz) -> Bool {
        return lhs.hero == rhs.hero
    }
}


