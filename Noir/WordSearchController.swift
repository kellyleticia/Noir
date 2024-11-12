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
    
    func updateGridForFoundWords(words: [Word]) {
        for word in words where word.wasFound {
            let (startRow, startCol) = (word.initPosition[0], word.initPosition[1])
            let (endRow, endCol) = (word.lastPosition[0], word.lastPosition[1])
            
            if word.orientation == .horizontal {
                for col in startCol...endCol {
                    grid[startRow][col].isHighlighted = true
                }
            } else if word.orientation == .vertical {
                for row in startRow...endRow {
                    grid[row][startCol].isHighlighted = true
                }
            }
        }
    }
}


struct LetterCell {
    let letter: String
    var isHighlighted: Bool = false
}

extension Color {
    static var random: Color {
        let colors: [Color] = [.red, .blue, .green, .purple, .orange, .yellow]
        return colors.randomElement() ?? .black
    }
}
