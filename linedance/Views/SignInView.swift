import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingMainApp = false
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
            
            // Social Sign In Options
            VStack(spacing: 16) {
                Text("Or sign in with")
                    .foregroundColor(.gray)
                
                HStack(spacing: 20) {
                    SocialSignInButton(image: "applelogo", text: "Apple") {
                        // Will implement in AuthenticationManager
                    }
                    
                    SocialSignInButton(image: "envelope.fill", text: "Google") {
                        // Will implement in AuthenticationManager
                    }
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
        .sheet(isPresented: $isShowingSignUp) {
            SignUpView()
        }
    }
    
    private func signIn() {
        // Will implement in next step with AuthenticationManager
    }
} 