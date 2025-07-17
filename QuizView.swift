//
//  QuizView.swift
//  Nguyen_Ai_BetaApp
//
//  Created by Phong Nguyen on 10/22/24.
//

import SwiftUI

struct QuizView: View {
    @State private var allQuestions: [Question] = []
    @State private var currentQuestionIndex: Int = 0
    @State private var selectedAnswerIndex: Int? = nil
    @State private var score: Int = 0
    @State private var isQuizStarted: Bool = false
    @State private var isQuizFinished: Bool = false
    @State private var questions: [Question] = []
    
    var body: some View {
        VStack {
            if isQuizFinished {
              
                VStack {
                    Text("Congratulations!")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .padding()
                        .scaleEffect(1.2)
                    Text("You scored \(score) out of \(currentQuestionIndex + 1)!")
                        .font(.title)
                        .padding()
                    
                    Button(action: resetQuiz) {
                        Text("Play Again")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.title2)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.top, 20)
                            .shadow(radius: 10)
                    }
                }
                .transition(.scale)
            } else {
                if isQuizStarted {
                    VStack {
                        Text(questions[currentQuestionIndex].question)
                            .font(.title2)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color.orange.opacity(0.2))
                            .cornerRadius(12)
                            .shadow(radius: 8)
                        
                        Spacer()

                        ForEach(0..<questions[currentQuestionIndex].options.count, id: \.self) { index in
                            Button(action: {
                                answerTapped(index)
                            }) {
                                Text(questions[currentQuestionIndex].options[index])
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedAnswerIndex == index ? (isCorrectAnswer(index) ? Color.green : Color.red) : Color.blue.opacity(0.6))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .padding(.horizontal)
                                    .shadow(radius: 5)
                                    .scaleEffect(selectedAnswerIndex == index ? 1.05 : 1.0)
                            }
                            .disabled(selectedAnswerIndex != nil)
                            .padding(.top, 5)
                        }
                    }
                    .padding()
                } else {
                    
                    VStack(spacing: 20) {
                        Text("Welcome to the Dota 2 Quiz!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.purple)
                            .padding(.top)
                        
                        Text("Answer 7 questions to test your Dota 2 knowledge. Select the correct option from the list. If you answer wrong, the quiz will end.")
                            .multilineTextAlignment(.center)
                            .font(.body)
                            .padding()
                            .background(Color.yellow.opacity(0.3))
                            .cornerRadius(12)
                            .shadow(radius: 8)
                        
                        Button("Start Quiz") {
                            startQuiz()
                        }
                        .frame(maxWidth: .infinity)
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 10)
                        .shadow(radius: 10)
                    }
                }
            }
        }
        .padding()
        .onAppear {
            loadQuestions()
        }
    }

    private func loadQuestions() {
        // Load your questions from the local JSON file
        if let url = Bundle.main.url(forResource: "questions", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                allQuestions = try JSONDecoder().decode([Question].self, from: data)
            } catch {
                print("Error loading questions: \(error)")
            }
        }
    }

    private func startQuiz() {
        if allQuestions.count >= 7 { // Ensure there are at least 7 questions available
            // Shuffle and take 7 random questions
            questions = allQuestions.shuffled().prefix(7).map { $0 }
        }
        currentQuestionIndex = 0
        score = 0
        isQuizStarted = true
        selectedAnswerIndex = nil
        isQuizFinished = false
    }

    private func answerTapped(_ index: Int) {
        selectedAnswerIndex = index
        if isCorrectAnswer(index) {
            score += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if currentQuestionIndex < 6 { // Only allow 7 questions
                    currentQuestionIndex += 1
                    selectedAnswerIndex = nil
                } else {
                    isQuizFinished = true
                }
            }
        } else {
            isQuizFinished = true
        }
    }

    private func isCorrectAnswer(_ index: Int) -> Bool {
        return questions[currentQuestionIndex].correctAnswer == index
    }

    private func resetQuiz() {
        isQuizFinished = false
        isQuizStarted = false
    }
}



