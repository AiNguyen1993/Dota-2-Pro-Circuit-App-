//
//  QuizViewModel.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Ai Nguyen on 10/22/24.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var selectedOption: Int? = nil

    init() {
        loadQuestions()
    }

    func loadQuestions() {
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                questions = try JSONDecoder().decode([Question].self, from: data)
                questions.shuffle()
            } catch {
                print("Error loading questions: \(error)")
            }
        }
    }

    func checkAnswer(_ answer: Int) -> Bool {
        return questions[currentQuestionIndex].correctAnswer == answer
    }

    func nextQuestion() {
        currentQuestionIndex += 1
    }
}


