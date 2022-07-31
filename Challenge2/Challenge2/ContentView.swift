//
//  ContentView.swift
//  Challenge2
//
//  Created by Peyton Gasink on 7/30/22.
//

import SwiftUI

struct ContentView: View {
    
    enum RPSMove: String, CaseIterable {
        case rock = "rock",
             paper = "paper",
             scissors = "scissors"
    }
    
    @State private var currentMove = RPSMove.allCases.randomElement()
    @State private var shouldWin = Bool.random()
    @State private var questionNum = 1
    @State private var score = 0
    @State private var showScoreAlert = false
    @State private var scoreAlertTitle = ""
    
    var body: some View {
        VStack {
            Text("Your score: \(score)")
            Text("I play \(String(currentMove!.rawValue)).")
            Text("Your goal is to \(shouldWin ? "beat" : "lose to") me.")
            
            HStack {
                Spacer()
                
                ForEach(RPSMove.allCases, id: \.self) { move in
                    Spacer()
                    
                    Button {
                        makeMove(move: move)
                    } label: {
                        getIcon(move: move)
                    }
                    .font(.largeTitle)
                    .frame(width: 75, height: 75)
                    .background(.blue)
                    .clipShape(Circle())
                    
                    Spacer()
                }
                
                Spacer()
            }
            .alert(scoreAlertTitle, isPresented: $showScoreAlert) {
                Button {
                    nextQuestion()
                } label: {
                    Text(questionNum < 10 ? "Next Question" : "Play Again")
                }
            } message: {
                Text("Your score after \(questionNum) \(questionNum == 1 ? "question" : "questions") is \(score).")
            }
        }
    }
    
    func makeMove(move: RPSMove) {
        var didWin: Bool
        switch move {
            case .rock:
                didWin = currentMove == RPSMove.scissors
            case .paper:
                didWin = currentMove == RPSMove.rock
            case .scissors:
                didWin = currentMove == RPSMove.paper
        }
        
        if didWin == shouldWin {
            score = score + 1
            scoreAlertTitle = "Correct"
        }
        else {
            score = score > 0 ? score - 1 : score
            scoreAlertTitle = "Incorrect"
        }
        
        showScoreAlert = true
    }
    
    func nextQuestion() {
        if questionNum == 10 {
            playAgain()
            return
        }
        
        questionNum = questionNum + 1
        setupQuestion()
    }
    
    func playAgain() {
        score = 0
        questionNum = 1
        setupQuestion()
    }
    
    func setupQuestion() {
        currentMove = RPSMove.allCases.randomElement()
        shouldWin.toggle()
    }
    
    func getIcon(move: RPSMove) -> Text {
        var icon: String
        switch move {
            case .rock:
                icon = "🪨"
            case .paper:
                icon = "🧻"
            case .scissors:
                icon = "✂️"
        }
        return Text(icon)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
