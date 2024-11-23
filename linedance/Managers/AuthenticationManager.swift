import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = true
    
    init() {
        // Check if user is already signed in
        checkAuthStatus()
    }
    
    private func checkAuthStatus() {
        // Simulate checking auth status
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // TODO: Implement actual auth check
            self.isAuthenticated = false
            self.isLoading = false
        }
    }
} 