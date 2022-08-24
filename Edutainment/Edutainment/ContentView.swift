//
//  ContentView.swift
//  Edutainment
//
//  Created by Mateusz Idziejczak on 22/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var multiplicationFrom = 2
    @State private var multiplicationUpTo = 3
    @State private var gameStarted = false
    @State private var questionNumber = 1
    @State private var num1 = 1
    @State private var num2 = 1
    @State private var answer: Int? = nil
    @State private var maxQuestions = 5
    @State private var score = 0
    @State private var endGame = false
    @State private var pulse = 1.0
    
    var body: some View {
        if !gameStarted {
            NavigationView {
                Form {
                    Section("Which multiplication table you want to practice?") {
                        VStack(alignment: .center) {
                            Text("From:")
                            HStack(alignment: .center) {
                                ForEach(2..<8, id: \.self) { num in
                                    Button(String(num)) {
                                        print(num)
                                        withAnimation {
                                            multiplicationFrom = num
                                        }
                                        if multiplicationUpTo < multiplicationFrom {
                                            withAnimation {
                                                multiplicationUpTo = num
                                            }
                                        }
                                    }
                                    .padding(10)
                                    .background(multiplicationFrom == num ? .yellow : .white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                            HStack(alignment: .center) {
                                ForEach(7..<13, id: \.self) { num in
                                    Button(String(num)) {
                                        withAnimation {
                                            multiplicationFrom = num
                                        }
                                        if multiplicationUpTo < multiplicationFrom {
                                            withAnimation {
                                                multiplicationUpTo = num
                                            }
                                        }
                                    }
                                    .padding(10)
                                    .background(multiplicationFrom == num ? .yellow : .white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                            Text("Up to:")
                            HStack(alignment: .center) {
                                ForEach(2..<8, id: \.self) { num in
                                    Button(String(num)) {
                                        withAnimation {
                                            multiplicationUpTo = num
                                        }
                                    }
                                    .padding(10)
                                    .background(multiplicationUpTo == num ? .yellow : .white)
                                    .disabled(num < multiplicationFrom)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                            HStack(alignment: .center) {
                                ForEach(7..<13, id: \.self) { num in
                                    Button(String(num)) {
                                        withAnimation {
                                            multiplicationUpTo = num
                                        }
                                    }
                                    .padding(10)
                                    .background(multiplicationUpTo == num ? .yellow : .white)
                                    .disabled(num < multiplicationFrom)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                }
                            }
                        }
                        .padding()
                    }
                    Section("How many questions?") {
                        HStack {
                            Button("5") {
                                withAnimation {
                                    maxQuestions = 5
                                }
                            }
                            .padding(10)
                            .background(maxQuestions == 5 ? .yellow : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            Button("10") {
                                withAnimation {
                                    maxQuestions = 10
                                }
                            }
                            .padding(10)
                            .background(maxQuestions == 10 ? .yellow : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            Button("20") {
                                withAnimation {
                                    maxQuestions = 20
                                }
                            }
                            .padding(10)
                            .background(maxQuestions == 20 ? .yellow : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        }
                    }
                }
                .buttonStyle(BorderlessButtonStyle())
                .navigationTitle("Edutainment")
                .toolbar {
                    Button("Start") {
                        startGame()
                    }
                }
            }
            .alert("End", isPresented: $endGame) {
                Button("OK") { }
            } message: {
                Text("Your final score is: \(score)/\(maxQuestions)")
            }

        } else {
            NavigationView {
                VStack {
                    Spacer()
                    Text("Question number \(questionNumber)")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    Text("What is \(num1) * \(num2)")
                        .font(.largeTitle)
                    Spacer()
                    TextField("answer", value: $answer, format: .number)
                        .keyboardType(.decimalPad)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                                .scaleEffect(pulse)
                                .opacity(2-pulse)
                        }
                        .padding()
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(questionNumber == maxQuestions ? "End" : "Next") {
                        nextQuestion()
                        answer = nil
                    }
                    .buttonStyle(.borderedProminent)
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .navigationTitle("Edutainment")
            }.onAppear {
                withAnimation {
                    pulse += 1
                }
                pulse = 1
            }
        }
    }
    
    func startGame() {
        gameStarted = true
        generateNumbers()
    }
    
    func nextQuestion() {
        questionNumber += 1
        if num1*num2==answer {
            score += 1
            //animation
        }
        if questionNumber > maxQuestions {
            gameStarted = false
            endGame = true
        }
        generateNumbers()
        withAnimation {
            pulse += 2
        }
        pulse = 1
    }
    
    func generateNumbers() {
        num1 = Int.random(in: multiplicationFrom...multiplicationUpTo)
        num2 = Int.random(in: multiplicationFrom...multiplicationUpTo)
        answer = nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
