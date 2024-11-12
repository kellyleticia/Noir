//
//  WordSearchView.swift
//  Noir
//
//  Created by Vitor Costa on 12/11/24.
//

import SwiftUI

struct WordSearchView: View {
    @EnvironmentObject var controller: WordSearchController
    
    var body: some View {
        VStack(spacing: 2) {
            Button("Show a hint") {
                controller.showHint()
            }
            
            Button("Reveal Word") {
                controller.revealWord()
            }
            
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
                    }
                }
            }
        }
        .padding()
        .cornerRadius(15)
    }
}

#Preview {
    WordSearchView()
        .environmentObject(WordSearchController())
}
