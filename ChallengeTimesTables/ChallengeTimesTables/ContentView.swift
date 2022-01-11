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
    case GameOver

    mutating func incrementQuestion(nQuestions: Int) {
        switch self {
        case .Settings:
            self = .Playing(0)
        case .Playing(let n):
            assert(n >= 0 && n < nQuestions)
            if n == nQuestions - 1 {
                self = .GameOver
            } else {
                self = .Playing(n+1)
            }
        case .GameOver:
            assert(false)
        }
    }
}

struct Question {
    let m1: Int
    let m2: Int
    let qNumber: Int
}

struct SettingsView: View {
    @Binding var correct: Int
    @Binding var gamePhase: GamePhase
    @Binding var questionList: [Question]
    @State var questions = 1.0
    @State var smallest = 1.0
    @State var largest = 10.0

    func startGame() {
        withAnimation {
            gamePhase = .Playing(0)
        }
        correct = 0
        questionList = []
        for qNumber in 0..<Int(questions) {
            let m1 = Int.random(in: Int(smallest)...Int(largest))
            let m2 = Int.random(in: Int(smallest)...Int(largest))
            questionList.append(Question(m1: m1, m2: m2, qNumber: qNumber))
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
    @State private var gamePhase: GamePhase = .Settings
    @State private var questionList: [Question] = []
    @State private var correct = 0
    @State private var answer = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    func checkAnswer() {
        var expectedAnswer = -1
        switch gamePhase {
        case .Settings:
            assert(false)
        case .Playing(let qNumber):
            expectedAnswer = questionList[qNumber].m1 * questionList[qNumber].m2
            alertMessage = "\(questionList[qNumber].m1) \u{00D7} \(questionList[qNumber].m2) = \(expectedAnswer)"
        case .GameOver:
            assert(false)
        }
        let a = Int(answer)
        print("answer         = <<\(answer)>>")
        print("a              = <<\(a)>>")
        print("expectedAnswer = <<\(expectedAnswer)>>")
        if (a ?? -1) == expectedAnswer {
            correct += 1
            gamePhase.incrementQuestion(nQuestions: questionList.count)
            answer = ""
        } else {
            showingAlert = true
            
        }
    }
    
    var body: some View {
        switch gamePhase {
        case .Settings:
            SettingsView(correct: $correct, gamePhase: $gamePhase, questionList: $questionList)
        case .Playing(let qNumber):
            List(questionList, id: \.qNumber) { q in
                if q.qNumber == qNumber {
                    VStack {
                        Spacer()
                        HStack {
                            Text("Score:")
                            Text("\(correct) / \(qNumber)")
                        }
                        Spacer()
                        Spacer()
                        Text("Question \(qNumber+1)")
                        Spacer()
                        Text("\(q.m1) \u{00D7} \(q.m2)").font(.largeTitle)
                        Spacer()
                        TextField("Your answer", text: $answer).font(.largeTitle)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color.yellow)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .onSubmit(checkAnswer)
                        Spacer()
                    }.alert(alertMessage, isPresented: $showingAlert) {
                        Button("OK", role: .cancel) {
                            gamePhase.incrementQuestion(nQuestions: questionList.count)
                            answer = ""
                            
                        }
                    }
                }
            }
        case .GameOver:
            Text("Game Over")
            HStack {
                Text("Score:")
                Text("\(correct) / \(questionList.count)")
            }

            HStack(alignment: .center) {
                Button("Play Again") {gamePhase = .Settings}
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
