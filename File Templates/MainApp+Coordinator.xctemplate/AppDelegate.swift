import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        // Custom initialization code, e.g., configure services
        print("AppDelegate didFinishLaunching")
        return true
    }
    
    // Add more UIApplicationDelegate methods if needed
}
