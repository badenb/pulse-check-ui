import Foundation
import Auth0

class AuthManager {
    static let shared = AuthManager()
    
    private let domain: String
    private let clientId: String
    
    private init?() {
        guard
            let domain = Bundle.main.infoDictionary?["AUTH0_DOMAIN"] as? String, !domain.isEmpty,
            let clientId = Bundle.main.infoDictionary?["AUTH0_CLIENT_ID"] as? String, !clientId.isEmpty
        else {
            print("❌ AuthManager initialization failed: Missing Auth0 configuration in Info.plist.")
            return nil
        }
        
        self.domain = domain
        self.clientId = clientId
    }
    
    private var authClient: Authentication {
        Auth0.authentication(clientId: clientId, domain: domain)
    }
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        authClient
            .login(
                usernameOrEmail: email,
                password: password,
                realmOrConnection: "Username-Password-Authentication",
                scope: "openid profile email"
            )
            .start { result in
                switch result {
                case .success(let credentials):
                    completion(.success(credentials.accessToken))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
