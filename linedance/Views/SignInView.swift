import SwiftUI

struct SignInView: View {
    @StateObject private var authManager = AuthenticationManager()
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
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
                    .disabled(isLoading)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textContentType(.password)
                    .disabled(isLoading)
            }
            .padding(.horizontal)
            
            // Sign In Button
            Button(action: signIn) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .purple]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .opacity(isLoading ? 0.5 : 1)
            )
            .cornerRadius(10)
            .disabled(isLoading)
            .padding(.horizontal)
            
            // Social Sign In Options
            VStack(spacing: 16) {
                Text("Or sign in with")
                    .foregroundColor(.gray)
                
                HStack(spacing: 20) {
                    SocialSignInButton(image: "applelogo", text: "Apple") {
                        Task {
                            await signInWithApple()
                        }
                    }
                    .disabled(isLoading)
                    
                    SocialSignInButton(image: "envelope.fill", text: "Google") {
                        Task {
                            await signInWithGoogle()
                        }
                    }
                    .disabled(isLoading)
                }
            }
            .padding(.top)
            
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
            .disabled(isLoading)
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
        Task {
            await performSignIn {
                try await authManager.signIn(email: email, password: password)
            }
        }
    }
    
    private func signInWithApple() async {
        await performSignIn {
            try await authManager.signInWithApple()
        }
    }
    
    private func signInWithGoogle() async {
        await performSignIn {
            try await authManager.signInWithGoogle()
        }
    }
    
    private func performSignIn(action: @escaping () async throws -> Void) async {
        guard !isLoading else { return }
        
        isLoading = true
        do {
            try await action()
            // Success is handled by AuthenticationManager's state
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
        isLoading = false
    }
} 