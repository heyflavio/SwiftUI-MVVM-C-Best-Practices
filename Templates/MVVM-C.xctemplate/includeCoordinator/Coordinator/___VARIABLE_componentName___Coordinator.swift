import SwiftUI
import Combine

class ___VARIABLE_componentName___Coordinator: ___VARIABLE_componentName___CoordinatorProtocol {
    
    // Define the Route enum inside the Coordinator for managing navigation destinations
    enum Route: Hashable {
        case `default`
    }
    
    // Manages a given modal shown in this current context
    // let showModalView = PassthroughSubject<Void, Never>()
    
    private let appCoordinator: any AppCoordinatorProtocol
    private var cancellables = Set<AnyCancellable>()
    
    required init(appCoordinator: any AppCoordinatorProtocol) {
        self.appCoordinator = appCoordinator
    }
    
    func navigate(to destination: Route) {
        self.appCoordinator.navigate(to: destination)
    }
    
    func pop() {
        self.appCoordinator.pop()
    }
    
    func view(for route: Route) -> some View {
        switch route {
        case .default:
            let emptyView = EmptyView()
            
            return emptyView
        }
    }
}
