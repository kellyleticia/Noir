//
//  WordSearchController.swift
//  Noir
//
//  Created by Vitor Costa on 12/11/24.
//

import SwiftUI

class WordSearchController: ObservableObject {
    let matrizGenerator = MatrizGenerator()
    @Published var grid: [[LetterCell]] = []
    @Published var highlightedWords: [(letter: String, position: (Int, Int))] = []
    @Published var selectedGrid: [CGRect : CGPoint] = [:]
    
    init() {
        matrizGenerator.boardSize = 10
        matrizGenerator.theme = "Animals"
        matrizGenerator.themeWords = [
            "cat", "dog", "elephant", "tiger", "lion", "zebra", "giraffe",
            "monkey","panda", "bird", "horse", "parrot", "rat", "turtle",
            "rabbit", "dolphin","fish", "shark", "owl", "otter", "seal",
            "camel", "kangaroo", "penguin","crocodile", "fox", "bear", "wolf",
            "butterfly", "bee", "monkey"
        ]
        matrizGenerator.generateGrid()
        
        self.grid = matrizGenerator.generatedGrid.map({ row in
            row.map({ letter in
                LetterCell(letter: letter)
            })
        })
    }
    
    func showHint() {
        let unfoundWords = matrizGenerator.words.filter { !$0.wasFound }
        guard let word = unfoundWords.randomElement() else { return }
        let wordSize = word.name.count
        
        let line = word.initPosition[0]
        let column = word.initPosition[1]
        
        switch word.orientation {
        case .horizontal:
            let randomLetter = Int.random(in: 0..<wordSize)
            grid[line][column + randomLetter].color = .blue
            
        case .vertical:
            let randomLetter = Int.random(in: 0..<wordSize)
            grid[line + randomLetter][column].color = .blue
        }
    }
    
    func revealWord() {
        let wordsNotFound = matrizGenerator.words.enumerated().filter { !$0.element.wasFound }
        guard !wordsNotFound.isEmpty else {
            return
        }
        
        let randomChoice = wordsNotFound.randomElement()!
        let originalIndex = randomChoice.offset
        var word = matrizGenerator.words[originalIndex]
        
        word.wasFound = true
        matrizGenerator.words[originalIndex] = word
        
        gotItRightWord(word: word)
    }
    
    func colorForGridItem(row: Int, col: Int) -> Color {
        switch grid[row][col].color {
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        case .red:
            return Color.red
        case .purple:
            return Color.purple
        case .orange:
            return Color.orange
        default:
            return Color.gray
        }
    }
    
    func confirmChoice() -> Bool {
        var rightChoice: Bool = false
        
        let string = String(highlightedWords.map { $0.letter }.joined())
        
        if let index = matrizGenerator.words.firstIndex(where: { $0.name == string }) {
            var word = matrizGenerator.words[index]
            word.wasFound = true
            matrizGenerator.words[index] = word
            gotItRightWord(word: word)
            rightChoice = true
        } else {
            for (_, position) in highlightedWords {
                let (row, col) = position
                grid[row][col].color = .gray
                rightChoice = false
            }
        }
        
        highlightedWords.removeAll()
        return rightChoice
    }
    
    private func gotItRightWord(word: Word) {
        let color = randomColor()
        
        let (startRow, startCol) = (word.initPosition[0], word.initPosition[1])
        let (endRow, endCol) = (word.lastPosition[0], word.lastPosition[1])
        
        if word.orientation == .horizontal {
            for col in startCol...endCol {
                grid[startRow][col].color = color
            }
        } else if word.orientation == .vertical {
            for row in startRow...endRow {
                grid[row][startCol].color = color
            }
        }
    }
    
    private func randomColor() -> Color {
        let colors: [Color] = [Color.red, Color.blue, Color.green, Color.purple, Color.orange]
        return colors.randomElement() ?? .black
    }
}


struct LetterCell {
    let letter: String
    var color: Color = .gray
    
}
