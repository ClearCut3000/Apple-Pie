//
//  Game.swift
//  Apple Pie
//
//  Created by Николай Никитин on 21.08.2021.
//

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    fileprivate var guessedLetters = [Character]()
    
    init (word: String, incorrectMovesRemaining: Int){
        self.word = word
        self.incorrectMovesRemaining = incorrectMovesRemaining
    }
    
    var guessedWord: String {
        var wordToShow = ""
        for letter in word {
            if guessedLetters.contains(Character(letter.lowercased())) {
                wordToShow += String(letter)
            } else {
                wordToShow += "_"
            }
        }
        return wordToShow
    }
    
    mutating func playerGuessed(letter: Character){
        let lowerCasedLetter = Character(letter.lowercased())
        guessedLetters.append(lowerCasedLetter)
        if !word.lowercased().contains(lowerCasedLetter){
            incorrectMovesRemaining -= 1
        }
    }
}

