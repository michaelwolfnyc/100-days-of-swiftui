//
//  ContentView.swift
//  ChallengeTimesTables
//
//  Created by Michael Wolf on 1/10/22.
//

import SwiftUI

enum GamePhase {
    case Settings
    case Playing(Int)
}

struct Question {
    let q: String
    let a: Int
    let qNumber: Int
}

struct SettingsView: View {
    @Binding var gamePhase: GamePhase
    @Binding var questionList: [Question]
    @State var questions = 1.0
    @State var smallest = 1.0
    @State var largest = 10.0

    func startGame() {
        withAnimation {
            gamePhase = .Playing(0)
        }
        questionList = []
        for qNumber in 0..<Int(questions) {
            let m1 = Int.random(in: Int(smallest)...Int(largest))
            let m2 = Int.random(in: Int(smallest)...Int(largest))
            let q = "\(m1) \u{00D7} \(m2)"
            let a = m1 * m2
            questionList.append(Question(q:q, a: a, qNumber: qNumber))
        }
    }

    var body: some View {
        Form {
            Section(header: Text("How many questions?")) {
                HStack {
                    Slider(value: $questions, in: 1...10, step: 1)
                    Text("\(questions.formatted())")
                }
            }
            Section(header: Text("Smallest number?")) {
                HStack {
                    Slider(value: $smallest, in: 1...largest, step: 1)
                    Text("\(smallest.formatted())")
                }
            }
            Section(header: Text("Largest number?")) {
                HStack {
                    Slider(value: $largest, in: smallest...12, step: 1)
                    Text("\(largest.formatted())")
                }
            }
        }
        Spacer()
        HStack(alignment: .center) {
            Button("START") {startGame()}
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        Spacer()
    }
}


struct ContentView: View {
    @State var gamePhase: GamePhase = .Settings
    @State var questionList: [Question] = []
    
    var body: some View {
        switch gamePhase {
        case .Settings:
            SettingsView(gamePhase: $gamePhase, questionList: $questionList)
        case .Playing(let qNumber):
            List(questionList, id: \.qNumber) { question in
                Text("q: \(question.q) a: \(question.a)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
