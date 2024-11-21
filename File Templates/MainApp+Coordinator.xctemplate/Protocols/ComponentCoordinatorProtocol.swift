import SwiftUICore

protocol ComponentCoordinatorProtocol {
    associatedtype Destination: Hashable
    associatedtype ContentView: View
    
    init(appCoordinator: any AppCoordinatorProtocol)
    
    func navigate(to destination: Destination)
    func pop()
    func view(for route: Destination) -> ContentView
}
