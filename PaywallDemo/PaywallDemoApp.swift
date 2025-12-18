//
//  PaywallDemoApp.swift
//  PaywallDemo
//
//  Created by Madi Sharipov on 18.12.2025.
//

import SwiftUI
import CoreData

@main
struct PaywallDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
