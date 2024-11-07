//
//  ContentView.swift
//  Noir
//
//  Created by Kelly Letícia Nascimento de Morais on 07/11/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    var body: some View {
        VStack {
            ToggleImmersiveSpaceButton()
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
