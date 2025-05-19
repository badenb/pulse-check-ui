import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var sessionManager: SessionManager
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Image("pulse_check_v3_transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300, alignment: .center)
            
            TextField("email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            SecureField("password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            Button(action: login) {
                if isLoading {
                    ProgressView()
                } else {
                    Text("log in")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.mint, Color.cyan, Color.blue, Color.purple]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(colorScheme == .light ? .white : .black)
                        .cornerRadius(8)
                }
            }
            .disabled(isLoading)
        }
        .padding(32)
    }
    
    func login() {
        isLoading = true
        errorMessage = nil
        
        sessionManager.login(email: email, password: password) { result in
            isLoading = false
            
            switch result {
            case .success:
                break
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

#Preview {
    LoginView()
}
