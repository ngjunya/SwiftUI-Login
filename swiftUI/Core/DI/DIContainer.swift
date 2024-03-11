//
//  DIContainer.swift
//  swiftUI
//
//  Created by jun ya Ng  on 06/12/2023.
//

import Foundation

final class DIContainer {
    // MARK: - Properties
    private var dependencies: [String: Dependency] = [:]
    private var instances: [String: Any] = [:]
    // MARK: - Singleton Definition
    static let shared = DIContainer()
    private init() {}
}

// MARK: - Methods

// MARK: Public
extension DIContainer {
    @discardableResult
    func register<T>(name: String = "\(T.self)",
                     scope: Dependency.Scope,
                     provider: @escaping Dependency.Provider<T>) -> Self {
        dependencies[name] = Dependency(
            name: name,
            scope: scope,
            provider: provider
        )
        return self
    }
    func resolve<T>(_ name: String = "\(T.self)") -> T {
        guard let dependency = dependencies[name] else {
            fatalError("No provider found for \"\(name)\"")
        }
        if case .container = dependency.scope {
            if instances[name] == nil {
                instances[name] = dependency.provider(self)
            }
            guard let instance = instances[name] as? T else {
                fatalError("Could not cast value to type \"\(T.self)\"")
            }
            return instance
        }
        let untypedInstance = dependency.provider(self)
        guard let instance = untypedInstance as? T else {
            fatalError("Could not cast value of type \"\(type(of: untypedInstance))\" to \"\(name)\"")
        }
        return instance
    }
    func printRegisteredDependencies() {
        print("registed dependencies")
        for(name, _) in dependencies {
            print("\(name)")
        }
    }
}
