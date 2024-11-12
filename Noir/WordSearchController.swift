//
//  WordSearchController.swift
//  Noir
//
//  Created by Vitor Costa on 12/11/24.
//

import Foundation

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
    }
}
