import SwiftUI

struct SignInView: View {
    @StateObject private var authManager = AuthenticationManager()
    @State private var email = ""
    @State private var password = ""
    @State private var showingError = false
    @State private var errorMessage = ""
    @State private var isShowingSignUp = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Logo/Title Section
            VStack(spacing: 8) {
                Text("Line Dance")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text("Welcome Back")
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
                    .textContentType(.password)
            }
            .padding(.horizontal)
            
            // Sign In Button
            Button(action: signIn) {
                Text("Sign In")
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
            
            Spacer()
            
            // Create account link
            Button(action: {
                isShowingSignUp = true
            }) {
                Text("Don't have an account? ")
                    .foregroundColor(.gray) +
                Text("Sign Up")
                    .foregroundColor(.blue)
            }
            .padding(.bottom)
        }
        .alert("Error", isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .sheet(isPresented: $isShowingSignUp) {
            SignUpView()
        }
    }
    
    private func signIn() {
        do {
            try authManager.signIn(email: email, password: password)
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
    }
} 