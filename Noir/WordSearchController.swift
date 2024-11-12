//
//  WordSearchController.swift
//  Noir
//
//  Created by Vitor Costa on 11/11/24.
//

import SwiftUI
import RealityKit

final class WordSearchController: ObservableObject {
    @Published var matrizGenerator = MatrizGenerator()
    
    init() {
        matrizGenerator.boardSize = 10
        matrizGenerator.theme = "Animals"
        matrizGenerator.themeWords = [
            "cat", "dog", "elephant", "tiger", "lion", "zebra", "giraffe",
            "monkey", "panda", "bird", "horse", "parrot", "rat", "turtle",
            "rabbit", "dolphin", "fish", "shark", "owl", "otter", "seal",
            "camel", "kangaroo", "penguin", "crocodile", "fox", "bear", "wolf",
            "butterfly", "bee", "monkey"
        ]
        matrizGenerator.generateGrid()
    }
    
    func showHint() {
        print("hint")
        matrizGenerator.showHint()
    }
    
    func makeLetterEntity(letter: String) -> ModelEntity {
        let textMesh = MeshResource.generateText(letter, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.1))
        let material = SimpleMaterial(color: .white, isMetallic: false)
        return ModelEntity(mesh: textMesh, materials: [material])
    }
}
