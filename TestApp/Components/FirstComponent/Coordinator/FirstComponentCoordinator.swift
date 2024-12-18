import SwiftUI

final class FirstComponentCoordinator: FirstComponentCoordinatorProtocol {    
    // Define the Screen enum inside the Coordinator for managing navigation destinations
    enum Route: Hashable {
        case `default`
    }
    
    private let appCoordinator: any AppCoordinatorProtocol
    
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
            return SecondView(
                viewModel: .init(
                    dependencies: .init(
                        coordinator: .init(appCoordinator: self.appCoordinator)
                    )
                )
            )
        }
    }
}
