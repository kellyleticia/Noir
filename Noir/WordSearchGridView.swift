import SwiftUI
import RealityKit

// Estrutura para exibir o grid em uma janela
struct WordSearchGridWindow: View {
    let controller = WordSearchController()
    
    var body: some View {
        RealityView { content in
            let gridAnchor = AnchorEntity(world: [0, 0, -1])

            // Preenche o grid com letras da generatedGrid do MatrizGenerator
            for row in 0..<controller.matrizGenerator.boardSize {
                for col in 0..<controller.matrizGenerator.boardSize {
                    let letter = controller.matrizGenerator.generatedGrid[row][col]
                    let letterEntity = controller.makeLetterEntity(letter: letter)
                    letterEntity.position = [Float(col) * 0.1, Float(-row) * 0.1, 0]
                    gridAnchor.addChild(letterEntity)
                    
                    letterEntity.generateCollisionShapes(recursive: true)
                }
            }
            content.add(gridAnchor)
        }
        .frame(width: 400, height: 400)
    }
}

#Preview(windowStyle: .automatic) {
    WordSearchGridWindow()
}

