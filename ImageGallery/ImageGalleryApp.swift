//
//  ImageGalleryApp.swift
//  ImageGallery
//
//  Created by Rodolphe Beck on 23/06/2024.
//

import SwiftData
import SwiftUI

@main
struct ImageGalleryApp: App {
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                GridView(modelContext: container.mainContext)
            }
            .modelContainer(container)
            .navigationViewStyle(.stack)
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: Item.self)
        } catch {
            fatalError("Failed to create ModelContainer for Item.")
        }
    }
    
}
