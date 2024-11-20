//
//  ContentView.swift
//  linedance
//
//  Created by Justus Voss on 11/19/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        NavigationView {
            DanceMenuView()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
