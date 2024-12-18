import Foundation
import SwiftUI
import Combine

final class SecondViewModel<ComponentCoordinator: SecondComponentCoordinatorProtocol>
where ComponentCoordinator.Destination == SecondComponentCoordinator.Route {
    
    // Inputs
    struct Inputs: SecondInputsProtocol {
        let inputSubject = PassthroughSubject<Void, Never>()
        let navigateSubject = PassthroughSubject<Void, Never>()
    }
    
    // Outputs
    struct Outputs: SecondOutputsProtocol {
        let outputSubject = PassthroughSubject<String, Never>()
        let showModalView = PassthroughSubject<Bool, Never>()
    }
    
    // Dependencies
    struct Dependencies {
        // Add services or other dependencies as needed
        let coordinator: ComponentCoordinator
    }
    
    let inputs: SecondInputsProtocol
    let outputs: SecondOutputsProtocol
    
    // Coordinator
    private var coordinator: ComponentCoordinator {
        self.dependencies.coordinator
    }
    
    // Dependencies
    private let dependencies: Dependencies
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        dependencies: SecondViewModel.Dependencies,
        inputs: SecondInputsProtocol = Inputs(),
        outputs: SecondOutputsProtocol = Outputs()
    ) {
        self.inputs = inputs
        self.outputs = outputs
        self.dependencies = dependencies
        
        self.bindInputs()
    }
    
    private func bindInputs() {
        self.inputs.inputSubject
            .map("Second screen text output")
            .sink { [weak self] output in
                self?.outputs.outputSubject.send(output)
                self?.coordinator.pop()
            }
            .store(in: &self.cancellables)
        
        self.inputs.navigateSubject
            .map(true)
            .bind(to: self.outputs.showModalView)
            .store(in: &self.cancellables)
        
        self.coordinator.showModalView
            .bind(to: self.outputs.showModalView)
            .store(in: &self.cancellables)
    }
    
}

//Coordinator wrappers
extension SecondViewModel {
    
    // The logic for determining which view to navigate to
    func destinationContent(for route: SecondComponentCoordinator.Route) -> some View {
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
