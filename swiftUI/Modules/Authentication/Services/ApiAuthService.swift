//
//  LoginService.swift
//  swiftUI
//
//  Created by jun ya Ng  on 05/09/2023.
//

import Foundation
import Moya
import Combine

final class ApiAuthService: ApiAuthProtocol {
    @Inject private var apiProvider: MoyaProvider<ApiEndpoint>
}

// MARK: - Extension
extension ApiAuthService {
    func signInWithApi(username: String, password: String) -> Future<User, AuthError> {
        return Future<User, AuthError> { [weak self] promise in
            guard let self else { return }
            apiProvider.request(.loginWithUsernamePassword) { result in
                switch result {
                case .success(let response):
                    do {
                        let data = try response.map(User.self)
                        promise(.success(data))
                    } catch {
                        promise(.failure(.authenticationFailed))
                    }
                case .failure:
                    promise(.failure(.authenticationFailed))
                }
            }
        }
    }
}

// MARK: - AuthProocol
protocol ApiAuthProtocol {
    func signInWithApi(username: String, password: String) -> Future<User, AuthError>
}

// MARK: - AuthError
enum AuthError: Error {
    case authenticationFailed
    case networkError
}
