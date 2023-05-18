//
//  Esprit_SpaceApp.swift
//  Esprit_Space
//
//  Created by Mac2021 on 14/3/2023.
//

import SwiftUI

import SwiftUI

@main

struct constunApp: App {

    

    let persistenceController = PersistenceController.shared

    //@State var user =  User(email: "oussama.sebai@esprit.tn", password: "12345" , numTel: 21824847, Age: 25)

    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {

        WindowGroup {

            LoginView()

                .environment(\.managedObjectContext, persistenceController.container.viewContext)

                .preferredColorScheme(isDarkMode ? .dark : .light)

        }

        .onChange(of: isDarkMode) { newValue in

                    UserDefaults.standard.set(newValue, forKey: "isDarkMode")

                }

    }

    init() {

            if let isDarkMode = UserDefaults.standard.value(forKey: "isDarkMode") as? Bool {

                self.isDarkMode = isDarkMode

            }

        }

}
