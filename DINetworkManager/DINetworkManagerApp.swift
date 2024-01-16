//
//  DINetworkManagerApp.swift
//  DINetworkManager
//
//  Created by Fatih Durmaz on 11.01.2024.
//

import SwiftUI

@main
struct DINetworkManagerApp: App {
    
    init() {
        let appareance = UINavigationBarAppearance()
        appareance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appareance
        UINavigationBar.appearance().scrollEdgeAppearance = appareance
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
