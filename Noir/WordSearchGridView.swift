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
        ZStack {
            WordSearchView(boardSize: matrizGenerator.boardSize, matrizGenerator: matrizGenerator)
//            RealityViewWindow()
//                .scaleEffect(0.6)
        }
//        .offset(x: -330, y: -300)
    }
    
    private func RealityViewWindow() -> some View {
        RealityView { content in
            // Preenche o grid com letras da generatedGrid do MatrizGenerator
            for row in 0..<matrizGenerator.boardSize {
                for col in 0..<matrizGenerator.boardSize {
                    let letter = matrizGenerator.generatedGrid[row][col]
                    let letterEntity = makeLetterEntity(letter: letter)
                    letterEntity.scale = [0.5, 0.5, 0.5]
                    letterEntity.position = [
                        Float(col) * 0.1,
                        Float(-row) * 0.1,
                        0
                    ]
                    content.add(letterEntity)
                }
            }
        }
    }

    // Cria as letras como entidades de modelo
    private func makeLetterEntity(letter: String) -> ModelEntity {
        let textMesh = MeshResource.generateText(letter, extrusionDepth: 0.02, font: .systemFont(ofSize: 0.1))
        let material = SimpleMaterial(color: .white, isMetallic: false)
        return ModelEntity(mesh: textMesh, materials: [material])
    }
}

#Preview(windowStyle: .volumetric) {
    WordSearchGridWindow()
}


struct WordSearchView: View {
    @State private var grid: [[LetterCell]]
    let boardSize: Int
    let matrizGenerator: MatrizGenerator
    @State private var highlightedWords: Set<String> = []

    init(boardSize: Int, matrizGenerator: MatrizGenerator) {
        self.boardSize = boardSize
        self.matrizGenerator = matrizGenerator
        self._grid = State(initialValue: matrizGenerator.generatedGrid.map { row in
            row.map { letter in LetterCell(letter: letter) }
        })
    }

    var body: some View {
        VStack(spacing: 2) {
            Button("Encontre uma palavra") {
                var letter = matrizGenerator.words.randomElement()
                letter?.wasFound = true
            }

            ForEach(0..<boardSize, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<boardSize, id: \.self) { col in
                        Text(grid[row][col].letter)
                            .font(.title)
                            .frame(width: 50, height: 50)                              .background(highlightedWords.contains(grid[row][col].letter) ? Color.random : Color.gray)
                            .cornerRadius(5)
                            .padding(4)
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .shadow(radius: 1)
                            .gesture(DragGesture()
                                .onChanged { value in
                                    let touchedLetter = grid[row][col].letter
                                    if matrizGenerator.verifycaWords(triedWord: touchedLetter) {
                                        highlightedWords.insert(touchedLetter)
                                    }
                                }
                                .onEnded { _ in
                                    highlightedWords.removeAll()
                                }
                            )
                    }
                }
            }
        }
        .padding()
        //.background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .onAppear {
            updateGridForFoundWords(words: matrizGenerator.words)
        }
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
