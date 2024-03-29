//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Mateusz Idziejczak on 21/05/2022.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinal = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var gamesPlayed = 0
    @State private var animationRotateAmount = [0.0, 0.0, 0.0]
    @State private var animationFadeAmount = [1.0, 1.0, 1.0]
    @State private var animationScaleAmount = [1.0, 1.0, 1.0]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.75, green: 0.15, blue: 0.25), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                        .scaleEffect(animationScaleAmount[number])
                        .opacity(animationFadeAmount[number])
                        .rotation3DEffect(.degrees(animationRotateAmount[number]), axis: (x: 0, y: 1, z: 0))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }.alert(scoreTitle, isPresented: $showingFinal) {
            Button("Reset", action: reset)
        } message: {
            Text("You have \(score)/8 points")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
        }
        withAnimation {
            animationRotateAmount[number] += 360
        }
        for num in 0...2 {
            if num != number {
                withAnimation {
                    animationFadeAmount[num] = 0.25
                    animationScaleAmount[num] = 0.75
                }
            }
        }
        gamesPlayed += 1
        showingScore = true
        if gamesPlayed == 8 {
            showingFinal = true
        }
    }
    
    func reset() {
        gamesPlayed = 0
        score = 0
        scoreTitle = ""
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animationRotateAmount = [0.0, 0.0, 0.0]
        animationFadeAmount = [1.0, 1.0, 1.0]
        animationScaleAmount = [1.0, 1.0, 1.0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
