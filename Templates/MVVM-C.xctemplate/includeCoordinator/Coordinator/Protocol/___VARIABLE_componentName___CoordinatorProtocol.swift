import SwiftUI
import Combine

protocol ___VARIABLE_componentName___CoordinatorProtocol: ComponentCoordinatorProtocol {
    associatedtype Destination: Hashable
    associatedtype ContentView: View
    
    /// Navigates to the specified destination
    func navigate(to destination: Destination)
    
    /// Pops the current view off the navigation stack
    func pop()
    
    /// Returns a view for the specified route
    func view(for route: Destination) -> ContentView
}
