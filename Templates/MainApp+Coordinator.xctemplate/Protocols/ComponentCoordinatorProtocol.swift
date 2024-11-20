import SwiftUICore

protocol ComponentCoordinatorProtocol {
    associatedtype Destination: Hashable
    associatedtype ContentView: View
    
    func navigate(to destination: Destination)
    func pop()
    func view(for route: Destination) -> ContentView
}
