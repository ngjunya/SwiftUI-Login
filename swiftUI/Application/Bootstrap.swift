//
//  Bootstrap.swift
//  swiftUI
//
//  Created by jun ya Ng  on 14/12/2023.
//

import Foundation
import Moya

extension AppDelegate {
    func bootstrap() {
        DIContainer.shared
            .register(scope: .container) { _ in MoyaProvider<ApiEndpoint>() }
            .register(scope: .container) { _ in ApiAuthService() as ApiAuthProtocol }
        DIContainer.shared.printRegisteredDependencies()
    }
}
