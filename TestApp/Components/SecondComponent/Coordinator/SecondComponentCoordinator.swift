import SwiftUI
import Combine

final class SecondComponentCoordinator: SecondComponentCoordinatorProtocol {
    
    // Define the Screen enum inside the Coordinator for managing navigation destinations
    enum Route: Hashable {
        case `default`
    }
    
    let showModalView = PassthroughSubject<Bool, Never>()

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
            let view = ThirdView(
                viewModel: .init(
                    dependencies: .init(
                        coordinator: self
                    )
                ))
            
            view.viewModel.outputs.dismissCurrentModalView
                .sink { [weak self] value in
                    self?.showModalView.send(value)
                }
                .store(in: &self.cancellables)
                
            return view
        }
    }
}
