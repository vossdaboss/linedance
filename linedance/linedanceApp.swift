//
//  linedanceApp.swift
//  linedance
//
//  Created by Justus Voss on 11/19/24.
//

import SwiftUI

@main
struct linedanceApp: App {
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager)
        }
    }
}
