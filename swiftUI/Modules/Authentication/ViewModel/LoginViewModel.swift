//
//  LoginViewModel.swift
//  swiftUI
//
//  Created by jun ya Ng  on 09/08/2023.
//

import Foundation
import Combine
import Alamofire
import Moya
import SwiftUI

// MARK: - View Event
enum LoginViewEvent {
    case onLoginTaped(email: String, password: String)
}

// MARK: - View Model Event
enum LoginViewModelEvent {
    case onError(message: String)
    case onSuccess
}

// MARK: - View State
struct LoginViewState {
    var isLoading = false
}

@MainActor
final class LoginViewModel: ObservableObject {
    // MARK: property Wrappers
    @Published private(set) var state = LoginViewState()
    @Inject()
    private var loginSrvice: ApiAuthProtocol
    // MARK: - Properties
    private(set) var event = PassthroughSubject<LoginViewModelEvent, Never>()
    private var cancellable = Set<AnyCancellable>()
}

// MARK: - Methods

// MARK: Public
extension LoginViewModel {
    func onViewEvent(event: LoginViewEvent) {
        switch event {
        case let .onLoginTaped(email, password):
            loginWithApi(email: email, password: password)
        }
    }
}

// MARK: Private
private extension LoginViewModel {
    func loginWithApi(email: String, password: String) {
        // Show loading
        state.isLoading = true
        // Call API
        loginSrvice
            .signInWithApi(username: email, password: password)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    event.send(.onError(message: error.localizedDescription))
                }
                // Hide loading
                state.isLoading = false
            } receiveValue: { [weak self] _ in
                guard let self else { return }
                event.send(.onSuccess)
                // Hide loading
                state.isLoading = false
            }
            .store(in: &cancellable)
    }
}
