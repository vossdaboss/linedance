//
//  ContentView.swift
//  linedance
//
//  Created by Justus Voss on 11/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some View {
        Group {
            if authManager.isAuthenticated {
                DanceMenuView()
            } else {
                SignInView()
            }
        }
    }
}

#Preview {
    ContentView()
}
