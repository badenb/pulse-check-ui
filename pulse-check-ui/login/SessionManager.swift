import Foundation

class SessionManager: ObservableObject {
    @Published var isAuthenticated = false
    
    private let authManager: AuthManager
    
    init(isAuthenticated: Bool = false) {
        guard let authManager = AuthManager.shared else {
            fatalError("❌ Failed to initialize AuthManager")
        }
        
        self.authManager = authManager
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authManager.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isAuthenticated = true
                    completion(.success(()))
                case .failure(let error):
                    self.isAuthenticated = false
                    completion(.failure(error))
                }
            }
        }
    }
    
    func logout() {
        isAuthenticated = false
    }
}
