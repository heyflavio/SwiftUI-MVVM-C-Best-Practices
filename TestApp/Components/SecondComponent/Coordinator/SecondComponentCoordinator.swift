import SwiftUI
import Combine

class SecondComponentCoordinator: SecondComponentCoordinatorProtocol {
    
    // Define the Screen enum inside the Coordinator for managing navigation destinations
    enum Route: Hashable {
        case `default`
    }
    
    let showModalView = PassthroughSubject<Bool, Never>()

    private let appCoordinator: AppCoordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(appCoordinator: AppCoordinator) {
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
