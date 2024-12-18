import Foundation
import SwiftUI
import Combine

final class ___VARIABLE_componentName___ViewModel<ComponentCoordinator: <#Component Coordinator Protocol#>>
where ComponentCoordinator.Destination == <#Component Coordinator#>.Route {
    
    // Inputs
    struct Inputs: ___VARIABLE_componentName___InputsProtocol {
        let inputSubject = PassthroughSubject<Void, Never>()
        let navigateSubject = PassthroughSubject<Void, Never>()
    }
    
    // Outputs
    struct Outputs: ___VARIABLE_componentName___OutputsProtocol {
        let outputSubject = PassthroughSubject<String, Never>()
        let showModalView = PassthroughSubject<Bool, Never>()
        let dismissCurrentModalView = PassthroughSubject<Bool, Never>()
    }
    
    // Dependencies
    struct Dependencies {
        let coordinator: ComponentCoordinator
    }
    
    let inputs: ___VARIABLE_componentName___InputsProtocol
    let outputs: ___VARIABLE_componentName___OutputsProtocol
    
    // Coordinator
    private var coordinator: ComponentCoordinator {
        self.dependencies.coordinator
    }
    
    // Dependencies
    private let dependencies: Dependencies
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        dependencies: ___VARIABLE_componentName___ViewModel.Dependencies,
        inputs: ___VARIABLE_componentName___InputsProtocol = Inputs(),
        outputs: ___VARIABLE_componentName___OutputsProtocol = Outputs()
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
                //self?.coordinator.navigate(to: .default)
                
                //Present Modal
                //self?.outputs.showModalView.send(true)
            }
            .store(in: &self.cancellables)
        
        //If applicable, to programmatically dismiss this current component (shown as a modal)
        self.inputs.navigateSubject
            .sink { [weak self] in
                //Present Modal
                self?.outputs.dismissCurrentModalView.send(false)
            }
            .store(in: &self.cancellables)
    }
}

// Coordinator wrappers
extension ___VARIABLE_componentName___ViewModel {
    
    // The logic for determining which view to navigate to
    func destinationContent(for route: <#Component Coordinator#>.Route) -> some View {
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
