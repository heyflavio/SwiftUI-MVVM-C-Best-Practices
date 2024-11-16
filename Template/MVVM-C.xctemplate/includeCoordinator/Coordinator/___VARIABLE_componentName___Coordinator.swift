import SwiftUI

class ___VARIABLE_componentName___Coordinator: ObservableObject {
    
    // Define the Screen enum inside the Coordinator for managing navigation destinations
    enum Route: Hashable {
        case `default`
    }
    
    //Manages a given modal shown in this current context
    let showModalView = PassthroughSubject<Void, Never>()
    
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
            let emptyView = EmptyView()
            
            //If applicable, to listen to the modal programmatically being dismissed
//            emptyView.viewModel.outputs
//                .dismissCurrentModalView
//                .sink { [weak self] value in
//                    self?.showModalView.send(value)
//                }
//                .store(in: &self.cancellables)
            
            return emptyView
        }
    }
}
