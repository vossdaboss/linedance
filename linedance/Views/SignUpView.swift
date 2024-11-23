import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isShowingMainApp = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Logo/Title Section
            VStack(spacing: 8) {
                Text("Line Dance")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Create your account")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 40)
            
            // Form Fields
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.newPassword)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.newPassword)
            }
            .padding(.horizontal)
            
            // Sign Up Button
            Button(action: signUp) {
                Text("Sign Up")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [.blue, .purple]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Social Sign In Options
            VStack(spacing: 16) {
                Text("Or sign up with")
                    .foregroundColor(.gray)
                
                HStack(spacing: 20) {
                    SocialSignInButton(image: "applelogo", text: "Apple") {
                        // Handle Apple sign in
                    }
                    
                    SocialSignInButton(image: "envelope.fill", text: "Google") {
                        // Handle Google sign in
                    }
                }
            }
            .padding(.top)
            
            Spacer()
            
            // Already have account link
            Button(action: {
                // Handle navigation to sign in
            }) {
                Text("Already have an account? ")
                    .foregroundColor(.gray) +
                Text("Sign In")
                    .foregroundColor(.blue)
            }
            .padding(.bottom)
        }
        .alert("Error", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .fullScreenCover(isPresented: $isShowingMainApp) {
            DanceMenuView()
        }
    }
    
    private func signUp() {
        // Validate inputs
        guard !email.isEmpty else {
            showError("Please enter your email")
            return
        }
        
        guard !password.isEmpty else {
            showError("Please enter a password")
            return
        }
        
        guard password == confirmPassword else {
            showError("Passwords don't match")
            return
        }
        
        // TODO: Implement actual sign up logic
        isShowingMainApp = true
    }
    
    private func showError(_ message: String) {
        errorMessage = message
        showingError = true
    }
}

struct SocialSignInButton: View {
    let image: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: image)
                Text(text)
            }
            .foregroundColor(.primary)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
} 