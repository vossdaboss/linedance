//
//  linedanceApp.swift
//  linedance
//
//  Created by Justus Voss on 11/19/24.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct linedanceApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
            NavigationView {
                ContentView()
            }
        }
    }
}
