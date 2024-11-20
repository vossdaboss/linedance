//
//  linedanceApp.swift
//  linedance
//
//  Created by Justus Voss on 11/19/24.
//

import SwiftUI

@main
struct linedanceApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .onAppear {
                // Ensure proper memory management for navigation
                let navigationBarAppearance = UINavigationBarAppearance()
                navigationBarAppearance.configureWithDefaultBackground()
                UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            }
        }
    }
}
