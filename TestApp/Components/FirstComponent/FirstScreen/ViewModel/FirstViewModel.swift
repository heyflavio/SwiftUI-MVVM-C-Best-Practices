import Foundation
import SwiftUI
import Combine

class FirstViewModel<ComponentCoordinator: FirstComponentCoordinatorProtocol>: ObservableObject where ComponentCoordinator.Destination == FirstComponentCoordinator.Route {
        
    // Inputs
    struct Inputs: FirstInputsProtocol {
        let inputSubject = PassthroughSubject<Void, Never>()
        let navigateSubject = PassthroughSubject<Void, Never>()
    }
    
    // Outputs
    struct Outputs: FirstOutputsProtocol {
        let outputSubject = PassthroughSubject<String, Never>()
        let showModalView = PassthroughSubject<Bool, Never>()
    }
    
    // Dependencies
    struct Dependencies {
        // Add services or other dependencies as needed
        let coordinator: ComponentCoordinator
    }
    
    let inputs: FirstInputsProtocol
    let outputs: FirstOutputsProtocol
    
    // Coordinator
    private var coordinator: ComponentCoordinator {
        self.dependencies.coordinator
    }
    
    // Dependencies
    private let dependencies: Dependencies
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        dependencies: FirstViewModel.Dependencies,
        inputs: FirstInputsProtocol = Inputs(),
        outputs: FirstOutputsProtocol = Outputs()
    ) {
        self.inputs = inputs
        self.outputs = outputs
        self.dependencies = dependencies
        
        self.bindInputs()
    }
    
    private func bindInputs() {
        self.inputs.inputSubject
            .sink { [weak self] in
                self?.outputs.outputSubject.send("Text output")
            }
            .store(in: &self.cancellables)
        
        self.inputs.navigateSubject
            .sink { [weak self] in
                //Present Navigation Stack
                self?.coordinator.navigate(to: .default)
                
                //Present Modal
                //self?.outputs.showModalView.send(true)
            }
            .store(in: &self.cancellables)
    }
    
}

//Coordinator wrappers
extension FirstViewModel {
    
    // The logic for determining which view to navigate to
    func destinationContent(for route: FirstComponentCoordinator.Route) -> some View {
        return self.coordinator.view(for: route)
    }
    
    // Full-screen content logic
    func fullScreenContent() -> some View {
        return self.coordinator.view(for: .default)
    }
    
    // Bottom-sheet content logic
    func bottomSheetContent() -> some View {
        return self.coordinator.view(for: .default)
    }
    
}
