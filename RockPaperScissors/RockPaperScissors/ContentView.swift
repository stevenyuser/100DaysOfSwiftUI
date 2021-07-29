//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Steven Yu on 7/27/21.
//

import SwiftUI

struct OptionImage: View {
    var move: String
    var name: String
    
    var body: some View {
        VStack {
            Text(move)
                .font(.largeTitle)
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: .black, radius: 2)
            Text(name)
        }
    }
}

struct ContentView: View {
    private var moves = ["🪨", "📄", "✂️"]
    private var moveNames = ["Rock", "Paper", "Scissors"]
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var numAnswered = 0
    @State private var showingScore = false
    
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Text("App's Move")
                    .font(.title)
                    .fontWeight(.semibold)
                OptionImage(move: "\(moves[appChoice])", name: "\(moveNames[appChoice])")
            }
            
            VStack {
                Text("Fight to")
                    .font(.title)
                    .fontWeight(.medium)
                Text(shouldWin ? "Win " : "Lose")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(shouldWin ? Color.green : Color.red)
            }
            
            HStack(spacing: 25) {
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.optionTapped(number)
                    }) {
                        OptionImage(move: "\(moves[number])", name: "\(moveNames[number])")
                    }
                }
            }
            
            HStack(spacing: 50){
                VStack {
                    Text("Current Score: ")
                    Text("\(score)-\(numAnswered)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text("Good Game!"), message: Text("Your score is \(score)."), dismissButton: .default(Text("New Round")) {
                    self.newRound()
            })
        }
    }
    
    func optionTapped(_ number: Int) {
        if shouldWin {
            if number == 0 {
                switch appChoice {
                case 2:
                    score += 1
                default:
                    score -= 1
                }
            } else if number == 1 {
                switch appChoice {
                case 0:
                    score += 1
                default:
                    score -= 1
                }
            } else if number == 2 {
                switch appChoice {
                case 1:
                    score += 1
                default:
                    score -= 1
                }
            }
        } else if !shouldWin {
            if number == 0 {
                switch appChoice {
                case 1:
                    score += 1
                default:
                    score -= 1
                }
            } else if number == 1 {
                switch appChoice {
                case 2:
                    score += 1
                default:
                    score -= 1
                }
            } else if number == 2 {
                switch appChoice {
                case 0:
                    score += 1
                default:
                    score -= 1
                }
            }
        }
        
        newMove()
        
        numAnswered += 1
        if numAnswered == 10 {
            showingScore = true
        }
    }
    
    func newMove() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func newRound() {
        score = 0
        numAnswered = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
