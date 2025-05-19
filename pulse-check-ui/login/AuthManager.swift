import Foundation
import Auth0

class AuthManager {
    static let shared = AuthManager()
    
    let DOMAIN = Bundle.main.infoDictionary?["AUTH0_DOMAIN"] as? String ?? ""
    let CLIENT_ID = Bundle.main.infoDictionary?["AUTH0_CLIENT_ID"] as? String ?? ""
    
    func login(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth0.authentication(clientId: CLIENT_ID, domain: DOMAIN)
            .login(usernameOrEmail: email, password: password, realmOrConnection: "Username-Password-Authentication", scope: "openid profile email")
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
