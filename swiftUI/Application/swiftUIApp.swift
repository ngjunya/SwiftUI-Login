//
//  swiftUIApp.swift
//  swiftUI
//
//  Created by jun ya Ng  on 07/07/2023.
//

import SwiftUI

@main
struct SwiftUIApp: App {
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LoginView()
            }
        }
    }
}
