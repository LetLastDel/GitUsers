//
//  GitUsersApp.swift
//  GitUsers
//
//  Created by A.Stelmakh on 6.07.2023.
//

import SwiftUI

@main
struct GitUsersApp: App {
    
    @StateObject private var dataController = DataController(name: "Model")

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .preferredColorScheme(.dark)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
            }
        }
    }
}

