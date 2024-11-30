import SwiftUI

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = false
    
    // Email/Password Authentication
    func signUp(email: String, password: String) throws {
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail
        }
        
        guard isValidPassword(password) else {
            throw AuthError.weakPassword
        }
        
        // For now, just authenticate if validation passes
        isAuthenticated = true
    }
    
    func signIn(email: String, password: String) throws {
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail
        }
        
        guard isValidPassword(password) else {
            throw AuthError.weakPassword
        }
        
        // For now, just authenticate if validation passes
        isAuthenticated = true
    }
    
    func signOut() {
        isAuthenticated = false
    }
    
    // Validation
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d).{8,}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}

// Custom errors
enum AuthError: LocalizedError {
    case invalidEmail
    case weakPassword
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address"
        case .weakPassword:
            return "Password must be at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number"
        }
    }
} 