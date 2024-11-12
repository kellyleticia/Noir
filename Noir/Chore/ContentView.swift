//
//  ContentView.swift
//  Noir
//
//  Created by Kelly Letícia Nascimento de Morais on 07/11/24.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    @State var animationResources: [AnimationResource] = []
    @State var model1 = try! Entity.loadModel(named: "robofeio.usdz")
    
    var body: some View {
        //        VStack {
        //            Model3D(named: "fenix.usdz") { model in
        //                model
        //                 .resizable()
        //                 .aspectRatio(contentMode: .fit)
        //            } placeholder: {
        //                ProgressView()
        //            }
        //
        //            Button("Change") {
        //                model1.playAnimation(animationResources[0].repeat(), transitionDuration: 0.5, startsPaused: false)
        //            }
        //        }
        VStack {
            RealityView { content in
                model1.transform.scale = SIMD3<Float>(0.001, 0.001, 0.001)
                if let animation = model1.availableAnimations.first {
                    model1.playAnimation(animation.repeat())
                }
                model1.playAnimation(animationResources[0].repeat(), transitionDuration: 0.5, startsPaused: false)
                content.add(model1)
            }
            
            Button("Change") {
                model1.playAnimation(model1.availableAnimations[3].repeat(), transitionDuration: 0.5, startsPaused: false)
            }
        }
        
        .onAppear {
            let definition = model1.availableAnimations[0].definition
            let battle = AnimationView(
                source: definition,
                name: "default subtree animation",
                bindTarget: nil,
                blendLayer: 0,
                repeatMode: .autoReverse,
                fillMode: [])
            
            var clipResources: AnimationResource = try! AnimationResource.generate(with: battle)
            model1.playAnimation(clipResources)
            animationResources.append(clipResources)
            
            model1.playAnimation(animationResources[0].repeat(), transitionDuration: 0.5, startsPaused: false)
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView()
        .environment(AppModel())
}


