//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Mateusz Idziejczak on 16/08/2022.
//

import SwiftUI

struct ContentView: View {
    var moves = ["rock", "paper", "scissors"]
    @State private var move = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionsAsked = 0
    @State private var showingAlert = false
    var body: some View {
        VStack {
            Spacer()
            Text("Your score is \(score)")
            Spacer()
            Text("My move is: \(moves[move])")
            Text("Pick an option so that you \(shouldWin ? "win" : "lose")")
            Spacer()
            Spacer()
            HStack {
                ForEach(0..<3) { mov in
                    Button {
                        optionTapped(mov)
                    } label: {
                        Text(moves[mov]).font(.largeTitle)
                    }
                }
            }
            Spacer()
        }.alert("This is the end! Your score is \(score)", isPresented: $showingAlert) {
            Button {
                
            } label: {
                Text("Done")
            }
        }
    }
    
    func optionTapped(_ num: Int) {
        if move == 0 {
            if shouldWin {
                if num == 1 {
                    score+=1
                } else {
                    score-=1
                }
            } else {
                if num == 2 {
                    score+=1
                } else {
                    score-=1
                }
            }
        } else if move == 1 {
            if shouldWin {
                if num == 2 {
                    score+=1
                } else {
                    score-=1
                }
            } else {
                if num == 0 {
                    score+=1
                } else {
                    score-=1
                }
            }
        } else if move == 2 {
            if shouldWin {
                if num == 0 {
                    score+=1
                } else {
                    score-=1
                }
            } else {
                if num == 1 {
                    score+=1
                } else {
                    score-=1
                }
            }
        }
        if score<0 {
            score = 0
        }
        questionsAsked+=1
        if questionsAsked == 10 {
            showingAlert = true
        }
        move = Int.random(in: 0...2)
        shouldWin.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
