//
//  TestAppApp.swift
//  TestApp
//
//  Created by Flavio Kruger on 12/10/24.
//

import SwiftUI
import SwiftData

@main
struct TestAppApp: App {
    // Linking AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: self.$appCoordinator.path) {
                // Inject your modules here
                FirstView(viewModel: .init(
                    dependencies: .init(
                        coordinator: .init(appCoordinator: self.appCoordinator))))
            }
        }
    }
}
