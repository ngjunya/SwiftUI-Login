//
//  network.swift
//  swiftUI
//
//  Created by jun ya Ng  on 24/10/2023.
//

import Foundation
import Moya

// MARK: - API Enum
enum ApiEndpoint {
    case loginWithUsernamePassword
}

// MARK: - API Endpoint
extension ApiEndpoint: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://my-json-server.typicode.com") else { fatalError("Base url is wrong") }
        return url
    }
    var path: String {
        switch self {
        case .loginWithUsernamePassword:
            return "/typicode/demo/posts/1"
        }
    }
    var method: Moya.Method {
        switch self {
        case .loginWithUsernamePassword:
            return .get
        }
    }
    var task: Moya.Task {
        return .requestPlain
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
