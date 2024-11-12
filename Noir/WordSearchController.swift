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
    
    func showHint() {
        var letter = self.matrizGenerator.words.randomElement()
        self.grid[2][2].color = .blue
    }
    
    func revealWord() {
        let number = Int.random(in: 0...matrizGenerator.words.count - 1)
        matrizGenerator.words[number].wasFound = true
        
        for word in matrizGenerator.words where word.wasFound {
            print(word.name)
            let (startRow, startCol) = (word.initPosition[0], word.initPosition[1])
            let (endRow, endCol) = (word.lastPosition[0], word.lastPosition[1])
            
            if word.orientation == .horizontal {
                for col in startCol...endCol {
                    grid[startRow][col].color = .green
                }
            } else if word.orientation == .vertical {
                for row in startRow...endRow {
                    grid[row][startCol].color = .green
                }
            }
        }
    }
    
    func colorForGridItem(row: Int, col: Int) -> Color {
        switch grid[row][col].color {
        case .green:
            return Color.green
        case .blue:
            return Color.blue
        default:
            return Color.gray
        }
    }
}


struct LetterCell {
    let letter: String
    var color: Color = .gray

}

extension Color {
    static var random: Color {
        let colors: [Color] = [.red, .blue, .green, .purple, .orange, .yellow]
        return colors.randomElement() ?? .black
    }
}
