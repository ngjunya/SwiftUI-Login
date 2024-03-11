//
//  Inject.swift
//  swiftUI
//
//  Created by jun ya Ng  on 06/12/2023.
//

import Foundation

@propertyWrapper
class Inject<T> {
    // MARK: - Properties
    let name: String?
    // MARK: Lazy
    lazy var wrappedValue = { () -> T in
        if let name = name {
            return DIContainer.shared.resolve(name)
        }
        return DIContainer.shared.resolve()
    }()
    // MARK: - Initializer
    init(_ name: String? = nil) {
        self.name = name
    }
}
