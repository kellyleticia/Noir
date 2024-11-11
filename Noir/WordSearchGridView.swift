import SwiftUI
import RealityKit

// Estrutura para exibir o grid em uma janela
struct WordSearchGridWindow: View {
    let matrizGenerator = MatrizGenerator()
    
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

    var body: some View {
        RealityViewWindow()
            .frame(width: 400, height: 400)
    }

    private func RealityViewWindow() -> some View {
        RealityView { content in
            let gridAnchor = AnchorEntity(world: [0, 0, -1])

            // Preenche o grid com letras da generatedGrid do MatrizGenerator
            for row in 0..<matrizGenerator.boardSize {
                for col in 0..<matrizGenerator.boardSize {
                    let letter = matrizGenerator.generatedGrid[row][col]
                    let letterEntity = makeLetterEntity(letter: letter)
                    letterEntity.position = [Float(col) * 0.1, Float(-row) * 0.1, 0]
                    gridAnchor.addChild(letterEntity)
                    
                    letterEntity.generateCollisionShapes(recursive: true)
                }
            }
            content.add(gridAnchor)
        }
    }

    // Cria as letras como entidades de modelo
    private func makeLetterEntity(letter: String) -> ModelEntity {
        let textMesh = MeshResource.generateText(letter, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.1))
        let material = SimpleMaterial(color: .white, isMetallic: false)
        return ModelEntity(mesh: textMesh, materials: [material])
    }
}

#Preview(windowStyle: .automatic) {
    WordSearchGridWindow()
}
