import SwiftUI
import SwiftData

@main
struct ___VARIABLE_componentName___App: App {
    // Linking AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var appCoordinator = AppCoordinator(path: NavigationPath())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: self.$appCoordinator.path) {
                self.appCoordinator.rootView()
            }
        }
    }
}
