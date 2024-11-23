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
            if authManager.isLoading {
                LoadingView()
            } else if authManager.isAuthenticated {
                DanceMenuView()
            } else {
                SignUpView()
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading...")
                .padding(.top)
        }
    }
}

#Preview {
    ContentView()
}
