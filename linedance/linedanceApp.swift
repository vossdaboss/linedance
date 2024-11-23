//
//  linedanceApp.swift
//  linedance
//
//  Created by Justus Voss on 11/19/24.
//

import SwiftUI

@main
struct linedanceApp: App {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor(Color(hex: "121212"))
        appearance.shadowColor = .clear // Removes the bottom border
        
        // For compact height - makes the nav bar shorter
        let compactAppearance = UINavigationBarAppearance()
        compactAppearance.configureWithTransparentBackground()
        compactAppearance.backgroundColor = UIColor(Color(hex: "121212"))
        compactAppearance.shadowColor = .clear
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = compactAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
        }
    }
}
