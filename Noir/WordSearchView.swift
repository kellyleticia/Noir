//
//  WordSearchView.swift
//  Noir
//
//  Created by Vitor Costa on 12/11/24.
//

import SwiftUI

struct WordSearchView: View {
    @EnvironmentObject var controller: WordSearchController
    @State private var choice: Bool?
    
    @State private var grid2: [CGPoint: CGRect] = [:]
    
    var body: some View {
        VStack(spacing: 2) {
            HStack {
                Button("Reveal Word") {
                    controller.revealWord()
                }
                .padding(.bottom, 10)
                
                Spacer()
                
                Text("\(controller.matrizGenerator.words.filter { $0.wasFound }.count)/\(controller.matrizGenerator.words.count)")
                    .font(.system(size: 32, weight: .bold))
                    .padding(.trailing, 16)
                    .padding(.bottom, 8)
                    .monospacedDigit()
                
                Spacer()
                
                Button {
                    choice = controller.confirmChoice()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundStyle(
                            choice == true ? Color.green :
                            choice == false ? Color.red :
                            Color.white)
                }
                .onChange(of: choice) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        choice = nil
                    })
                }
                .padding(.bottom, 10)
                
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
                                    print("onGeometryChange", row, col)
                                    if row == 0, col == 0 {
                                        print(frame)
                                    }
                                    grid2[CGPoint(x: row, y: col)] = frame
                                }
                            )
                    }
                }
            }
        }
        .padding()
        .cornerRadius(15)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let position = value.location
                    
                    guard let point = grid2.first(where: { $0.value.contains(position) })?.key else { return }
                    
                    let row = Int(point.x)
                    let col = Int(point.y)
                    let touchedGrid = controller.grid[row][col]
                    controller.grid[row][col].color = .pink
                    print("Ponto: \(position)", "Valor: \((row,col))")
                    
                    let addLetter = controller.highlightedWords.contains(where: {
                        $0.letter == touchedGrid.letter && $0.position == (row, col)
                    })
                    
                    if !addLetter {
                        controller.highlightedWords.append((letter: touchedGrid.letter, position: (row, col)))
                    }
                    
                }
        )
        
        .onAppear {
            print(controller.selectedGrid.keys.count)
        }
    }
}

#Preview {
    WordSearchView()
        .environmentObject(WordSearchController())
}
