import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authManager: AuthenticationManager
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
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
            
            Spacer()
            
            // Already have account link
            Button(action: {
                dismiss()
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
    }
    
    private func signUp() {
        guard password == confirmPassword else {
            errorMessage = "Passwords don't match"
            showingError = true
            return
        }
        
        do {
            try authManager.signUp(email: email, password: password)
            dismiss()
        } catch {
            errorMessage = error.localizedDescription
            showingError = true
        }
    }
} 