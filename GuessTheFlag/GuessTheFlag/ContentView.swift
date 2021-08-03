//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Steven Yu on 7/25/21.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var rotationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var offsetAmount: CGFloat = 0.0
    @State private var tiltAmount = 0.0
    
    @State private var selectedFlag = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                        
                        self.selectedFlag = number
                        
                        withAnimation(.default) {
                            self.opacityAmount = 0.25
                        }
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                    .rotation3DEffect(
                        .degrees(number == self.correctAnswer ? self.rotationAmount : 0),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .opacity(number == self.correctAnswer ? 1 : self.opacityAmount)
                    .rotationEffect(
                        .degrees((number != self.correctAnswer && number == self.selectedFlag) ? self.tiltAmount : 0)
                    )
                    .offset(y: (number != self.correctAnswer && number == self.selectedFlag) ? self.offsetAmount : 0)
                }
                
                VStack {
                    Text("Current Score:")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("\(score)")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)."), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct! That's the flag of \(countries[number])."
            score += 1
            
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.rotationAmount += 360
            }
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])."
            score -= 1
            
            withAnimation(.interpolatingSpring(stiffness: 20, damping: 5)) {
                self.tiltAmount += 20
            }
            
            withAnimation(.default) {
                self.offsetAmount += 15
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        withAnimation(.default) {
            opacityAmount = 1
            tiltAmount = 0
            offsetAmount = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
