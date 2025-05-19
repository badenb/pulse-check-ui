import Foundation

class SessionManager: ObservableObject {
    @Published var isAuthenticated = false
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        AuthManager.shared.login(email: email, password: password) { result in
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
