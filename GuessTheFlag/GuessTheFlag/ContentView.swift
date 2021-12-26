//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Michael Wolf on 12/17/21.
//

import SwiftUI

struct FlagRender: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    let gameLength = 8
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State var nattempts = 0
    @State var ncorrect = 0
    @State var showingScore = false
    @State var scoreText = ""

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func scoreIt(_ number: Int) {
        showingScore = true
        nattempts += 1
        if number == correctAnswer {
            ncorrect += 1
            scoreText = "Correct!"
        }
        else {
            scoreText = "Wrong. You picked \(countries[number])"
        }
        if nattempts >= gameLength {
            scoreText += "\nFinal Score \(ncorrect)/\(nattempts)"
            ncorrect = 0
            nattempts = 0
        }
    }
    
    var body: some View {
        ZStack {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                ], center: .top, startRadius: 200, endRadius: 400)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    
                    Text("Guess the Flag")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.white)
                    
                    VStack(spacing: 30) {
                        VStack {
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.heavy))
                                .foregroundStyle(.secondary)
                            Text(countries[correctAnswer])
                                .font(.largeTitle)

                        }
                        ForEach(0..<3) { number in
                            Button {
                                scoreIt(number)
                            } label: {
                                FlagRender(image: countries[number])
                            }
                        }
                    }.frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                        
                    Text("Score: \(ncorrect) / \(nattempts)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                    
                    Spacer()
                }.padding()
        }.alert(scoreText, isPresented: $showingScore) {
             Button("OK", role: .none, action: askQuestion)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
