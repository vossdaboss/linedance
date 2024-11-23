import SwiftUI
import FirebaseAuth
import AuthenticationServices

class AuthenticationManager: ObservableObject {
    @Published var isAuthenticated = false
    @Published var isLoading = true
    @Published var currentUser: User?
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    init() {
        authStateHandler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.currentUser = user
            self?.isAuthenticated = user != nil
            self?.isLoading = false
        }
    }
    
    deinit {
        if let handler = authStateHandler {
            Auth.auth().removeStateDidChangeListener(handler)
        }
    }
    
    // Email/Password Authentication
    func signUp(email: String, password: String) async throws {
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail
        }
        
        guard isValidPassword(password) else {
            throw AuthError.weakPassword
        }
        
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // Social Authentication
    func signInWithApple() async throws {
        let helper = SignInWithAppleHelper()
        let tokens = try await helper.startSignInWithAppleFlow()
        
        // Create the OAuth credential using the non-deprecated method
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: tokens.token,
            accessToken: nil
        )
        
        try await Auth.auth().signIn(with: credential)
    }
    
    // Google Sign In will be implemented after adding dependencies
    func signInWithGoogle() async throws {
        throw AuthError.configurationError
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
    case invalidCredential
    case configurationError
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail:
            return "Please enter a valid email address"
        case .weakPassword:
            return "Password must be at least 8 characters and contain at least one uppercase letter, one lowercase letter, and one number"
        case .invalidCredential:
            return "Invalid credentials"
        case .configurationError:
            return "This feature is not available right now"
        }
    }
} 