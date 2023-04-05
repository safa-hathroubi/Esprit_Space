//
//  Esprit_SpaceApp.swift
//  Esprit_Space
//
//  Created by Mac2021 on 14/3/2023.
//

import SwiftUI

@main
struct Esprit_SpaceApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
