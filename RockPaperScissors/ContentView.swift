//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Liam Cashel on 1/29/24.
//

import SwiftUI

struct ContentView: View {
    // property to hold possible moves
    let moves = ["rock","paper","scissors"]
    // tracking game outcomes
    @State private var appChoice = Int.random(in: 0...2)
    @State private var outcome = false
    
    @State private var score = 0
    @State private var turns = 0
    @State private var showingScore = false
    @State private var alertMessage = ""
    @State private var showMove = false
    @State private var showGameOver = false
    
    
    var body: some View {
        ZStack {
            //background
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.6),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 50, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                //primary content - title and score
                Spacer()
                Spacer()
                Text("The game is RPS")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    // holds the prompt and the selection buttons
                    VStack {
                        Text("Make your selection")
                            .foregroundStyle(.white)
                            .font(.subheadline.weight(.heavy))
                    }
                    HStack {
                        ForEach(0..<3) { move in
                            Button{
                                userSelect(move)
                            } label: {
                                Text("\(moves[move])")
                            }
                            .font(.title2)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.red)
                            .clipShape(.capsule)
                            .disabled(showMove)
                            .opacity(showMove ? 0.4:1.0)
                        }
                    }
                    Spacer()
                }
            }
            VStack {
                Text("\(alertMessage)")
            }
            .foregroundStyle(showMove ? .black: .clear)
            VStack {
                Spacer()

                Spacer()
                Text("Youre score is \(score)")
                Text("Turn \(turns)")
            }
            .foregroundStyle(showingScore ? .black: .clear )
        }
        
        .alert(alertMessage, isPresented: $showGameOver) {
            Button("Restart", action: restart)
        }
    }
    func userSelect(_ number: Int) {
        if number == 0 && appChoice == 2 {
            score += 1
            alertMessage = "Rock beats Scissors. You win!"
            print("you win!")
        } else if number == 1 && appChoice == 0 {
            score += 1
            alertMessage = "Paper beats Rock. You win!"
            print("you win!")
        } else if number == 2 && appChoice == 1 {
            score += 1
            alertMessage = "Scissors beats Paper. You win!"
            print("you win!")
        } else {
            alertMessage = ("I chose \(moves[appChoice]). You lose")
            print("I chose \(moves[appChoice]). You lose")
        }
        shuffle()
        showingScore = true
    }
    
    
    
    // func to shuffle, count turns and end game
    func shuffle() {
        showMove = true
        delay(interval: 2) {
            showMove = false
        }
        print("shuffling")
        appChoice = Int.random(in: 0...2)
        if turns > 9 {
            print("game over")
            alertMessage = ("You're score was \(score)")
            showGameOver = true
        } else {
            turns += 1
        }
    }
    
    func restart() {
        score = 0
        turns = 0
        showingScore = false
        showGameOver = false
        print("game restarted")
    }
    
    func delay(interval: TimeInterval, closure: @escaping () -> Void) {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: closure)
        }
    
}

#Preview {
    ContentView()
}
