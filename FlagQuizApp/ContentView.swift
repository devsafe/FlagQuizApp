//
//  ContentView.swift
//  FlagQuizApp
//
//  Created by Сахар Кубический on 07.05.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["USA", "Russia", "Greece", "Germany", "Canada", "Brazil", "Bangladesh", "Argentina"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.pink, .yellow]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    Text("Choose flag: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) {number in
                    Button(action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 2))
                            .shadow(color: .white, radius: 200)
                            
                    }
                }
                
                .frame(width: 250, height: 130)
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.black)
                    .shadow(color: .pink, radius: 35)
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Total score: \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }

    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct answer!"
            score += 1
        } else {
            scoreTitle = "Incorrect answer! This is flag \(countries[number]) country."
            score -= 1
        }
    }
}
























struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
