//
//  Dependency.swift
//  swiftUI
//
//  Created by jun ya Ng  on 06/12/2023.
//

import Foundation

struct Dependency {
    // MARK: - Types
    typealias Provider<T> = (_ container: DIContainer) -> T
    typealias AnyProvider = Provider<Any>
    // MARK: - Enums
    enum Scope {
        case container, transient
    }
    // MARK: - Properties
    let name: String
    let scope: Scope
    let provider: AnyProvider
}
