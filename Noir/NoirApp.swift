//
//  NoirApp.swift
//  Noir
//
//  Created by Kelly Letícia Nascimento de Morais on 07/11/24.
//

import SwiftUI

@main
struct NoirApp: App {
    @StateObject private var controller: WordSearchController = .init()
    
    var body: some Scene {
        WindowGroup {
            WordSearchGridWindow()
                .environmentObject(controller)
        }
        .windowStyle(.plain)
    }
}
