//
//  WordSearchGridView.swift
//  Noir
//
//  Created by Vitor Costa on 11/11/24.
//

import SwiftUI
import RealityKit

// Estrutura para exibir o grid em uma janela
struct WordSearchGridWindow: View {
    @EnvironmentObject var controller: WordSearchController
    
    var body: some View {
        VStack {
            Button {
                controller.showHint()
            } label: {
                Text("Start Game")
                    .font(.system(size: 48, weight: .semibold))
                    .font(.headline)
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    WordSearchGridWindow()
        .environmentObject(WordSearchController())
}

