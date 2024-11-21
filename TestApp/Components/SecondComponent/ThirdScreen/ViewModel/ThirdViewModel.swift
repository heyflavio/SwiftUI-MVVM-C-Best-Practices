import Foundation
import SwiftUI
import Combine

final class ThirdViewModel<ComponentCoordinator: SecondComponentCoordinatorProtocol>
where ComponentCoordinator.Destination == SecondComponentCoordinator.Route {
    
    // Inputs
    struct Inputs: ThirdInputsProtocol {
        let inputSubject = PassthroughSubject<Void, Never>()
        let navigateSubject = PassthroughSubject<Void, Never>()
    }
    
    // Outputs
    struct Outputs: ThirdOutputsProtocol {
        let outputSubject = PassthroughSubject<String, Never>()
        let showModalView = PassthroughSubject<Bool, Never>()
        let dismissCurrentModalView = PassthroughSubject<Bool, Never>()
    }
    
    struct Dependencies {
        // Add services or other dependencies as needed
        let coordinator: ComponentCoordinator
    }
    
    let inputs: ThirdInputsProtocol
    let outputs: ThirdOutputsProtocol
    
    // Coordinator
    private var coordinator: ComponentCoordinator {
        self.dependencies.coordinator
    }
    
    // Dependencies
    private let dependencies: Dependencies
    
    private var cancellables = Set<AnyCancellable>()
    
    init(
        dependencies: ThirdViewModel.Dependencies,
        inputs: ThirdInputsProtocol = Inputs(),
        outputs: ThirdOutputsProtocol = Outputs()
    ) {
        self.inputs = inputs
        self.outputs = outputs
        self.dependencies = dependencies
        
        self.bindInputs()
    }
    
    private func bindInputs() {
        self.inputs.inputSubject
            .map("Last Text output")
            .bind(to: self.outputs.outputSubject)
            .store(in: &self.cancellables)
        
        //If applicable, to programmatically dismiss a modal being shown on top
        self.coordinator.showModalView
            .bind(to: self.outputs.showModalView)
            .store(in: &self.cancellables)
        
        //If applicable, to programmatically dismiss this current component (shown as a modal)
        self.inputs.navigateSubject
            .map(false)
            .bind(to: self.outputs.dismissCurrentModalView)
            .store(in: &self.cancellables)
    }
    
}

//Coordinator wrappers
extension ThirdViewModel {
    
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
