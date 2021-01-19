//
//  FinalTaskAppApp.swift
//  FinalTaskApp
//
//  Created by Field Employee on 1/18/21.
//

import SwiftUI

@main
struct FinalTaskAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
