//
//  WordSearchView.swift
//  Noir
//
//  Created by Vitor Costa on 12/11/24.
//

import SwiftUI

struct WordSearchView: View {
    @EnvironmentObject var controller: WordSearchController
    
    @State var grid: [CGRect : CGPoint] = [:]
    
    var body: some View {
        VStack(spacing: 2) {
            HStack {
                Button("Reveal Word") {
                    controller.revealWord()
                }
                .padding(.bottom, 10)
                Spacer()
                Button {
                    controller.showHint()
                } label: {
                    Image(systemName: "lightbulb.max.fill")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 10)
            }
            .frame(maxWidth: 600)
            
            ForEach(0..<controller.matrizGenerator.boardSize, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<controller.matrizGenerator.boardSize, id: \.self) { col in
                        Text(controller.grid[row][col].letter)
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(controller.colorForGridItem(row: row, col: col))
                            .cornerRadius(5)
                            .padding(4)
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold))
                            .shadow(radius: 1)
                            .onGeometryChange(
                                for: CGRect.self,
                                of: { proxy in
                                    proxy.frame(in: .global)
                                },
                                action: { frame in
                                    grid[frame] = CGPoint(x: row, y: col)
                                }
                            )
                            .onTapGesture {
                                let touchedLetter = controller.grid[row][col].letter
                                controller.grid[row][col].color = .pink
                                controller.highlightedWords.append((letter: touchedLetter, position: (row, col)))
                            }
                    }
                }
            }
            Button("Confirm choice") {
                controller.confirmChoice()
                print(controller.highlightedWords)
                controller.highlightedWords.removeAll()
            }
            .padding(.top, 10)
        }
        .padding()
        .cornerRadius(15)
        .simultaneousGesture(
            DragGesture()
                .onChanged { value in
                    let position = value.location
                    if let frame = grid.keys.first(where: {
                        $0.contains(position)
                    }), let point = grid[frame] {
                        let row = Int(point.x)
                        let col = Int(point.y)
                        let touchedLetter = controller.grid[row][col].letter
                        controller.grid[row][col].color = .pink
                        if controller.highlightedWords.contains(where: {
                            $0.letter == touchedLetter && $0.position == (row, col)
                        }) {
                            return
                        }
                        controller.highlightedWords.append((letter: touchedLetter, position: (row, col)))
                    }
                    
                }
        )
    }
}

#Preview {
    WordSearchView()
        .environmentObject(WordSearchController())
}
