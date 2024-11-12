import SwiftUI
import RealityKit

struct WordSearchGridWindow: View {
    @StateObject private var controller = WordSearchController()
    var body: some View {
        ZStack {
            WordSearchView(boardSize: controller.matrizGenerator.boardSize, matrizGenerator: controller.matrizGenerator)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    WordSearchGridWindow()
}


struct WordSearchView: View {
    @State private var grid: [[LetterCell]]
    let boardSize: Int
    let matrizGenerator: MatrizGenerator
    
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
                grid[2][2].isHighlighted = true
                letter?.wasFound = true
            }
            
            ForEach(0..<boardSize, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<boardSize, id: \.self) { col in
                        Text(grid[row][col].letter)
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(grid[row][col].isHighlighted ? Color.random : Color.gray)
                            .cornerRadius(5)
                            .padding(4)
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .shadow(radius: 1)
                            .gesture(DragGesture()
                                .onChanged { value in
                                    let touchedLetter = grid[row][col].letter
                                    if matrizGenerator.verifycaWords(triedWord: touchedLetter) {
                                        
                                    }
                                }
                            )
                    }
                }
            }
        }
        .padding()
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
