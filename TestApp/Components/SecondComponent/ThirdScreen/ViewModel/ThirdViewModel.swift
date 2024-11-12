import Foundation
import SwiftUI
import Combine

class ThirdViewModel: ObservableObject {
    
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
        let coordinator: SecondComponentCoordinator
    }
    
    let inputs: ThirdInputsProtocol
    let outputs: ThirdOutputsProtocol
    
    // Coordinator
    private var coordinator: SecondComponentCoordinator {
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
        
        //If applicable, to programmatically dismiss a modal being shown on top
        self.coordinator.showModalView
            .sink { [weak self] value in
                self?.outputs.showModalView.send(value)
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
