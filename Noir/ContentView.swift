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
        RealityView { content in
            let model = await try! ModelEntity(named: "fenix")
            model.transform.scale = SIMD3<Float>(0.001, 0.001, 0.001)
            if let animation = model.availableAnimations.first {
                model.playAnimation(animation.repeat())
            }
            content.add(model)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environment(AppModel())
}
