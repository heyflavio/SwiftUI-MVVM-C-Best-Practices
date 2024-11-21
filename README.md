# [WIP] SwiftUI & MVVM-C: Best Practices

## Overview

This codebase demonstrates best practices for implementing and testing applications using **SwiftUI** in combination with the **MVVM+C (Model-View-ViewModel + Coordinator)** pattern. The focus is on achieving a clear **separation of concerns**, adhering to **SOLID principles**, and ensuring high testability through **Unit Testing**.

## Features

- **SwiftUI** for declarative UI development.
- **MVVM+C** architecture for modular and scalable code.
- **Dependency Injection** to promote flexibility and testability.
- **Protocol-Oriented Programming** to decouple components.
- **Unit Testing** with comprehensive test cases for ViewModels, Coordinators, and business logic.
- **Combine** framework for reactive programming and data binding.

## Project Structure

This project serves as an **abstraction** of a real-life application, providing a simplified yet scalable structure for modular development. The project is organized into two main sections: `AppRoot` and `Components`. 

- The `AppRoot` handles the overall application lifecycle and navigation setup through the root coordinator. 
- The `Components` folder follows a feature-based modular structure, where each component contains its own `Coordinator` and one or more `Screens`. Each screen consists of its own `View`, `ViewModel`, and associated protocols for `Input` and `Output` interactions.
- The `Extensions` folder provides a space for reusable utilities and helpers. For this project, it is where you find a View extension for binding Combine publishers to SwiftUI state, and a Publisher extension for mapping and binding Combine publishers.

This structure aims for a clear separation of concerns, enhances testability, and promotes scalability. Additionally, the `Tests` folder mirrors the `Components` structure, providing targeted unit tests for each feature module and its screens.


```plaintext
TestApp
│
├── ApplicationRoot
│   ├── Protocols
│   │   ├── AppCoordinatorProtocol.swift
│   │   └── ComponentCoordinatorProtocol.swift
│   ├── AppCoordinator.swift                                // Root coordinator managing app flow
│   ├── AppDelegate.swift                                   // App lifecycle (if required)
│   └── TestAppApp.swift                                    // SwiftUI App entry point
│
├── Components                                              // Modular feature-based components
│   ├── [ComponentName]                                     // Example: FirstComponent
│   │   ├── Coordinator
│   │   │   ├── [ComponentCoordinator].swift                // Example: FirstComponentCoordinator
│   │   │   └── Protocols                                   // Coordinator protocols
│   │   │       └── [ComponentCoordinatorProtocol].swift
│   │   ├── [ScreenName]                                    // Example: FirstScreen
│   │   │   ├── ViewModel
│   │   │   │   ├── [ScreenViewModel].swift
│   │   │   │   └── Protocols                               // Input/Output protocols for ViewModel interactions
│   │   │   │       ├── [InputsProtocol].swift              // Example: FirstInputsProtocol
│   │   │   │       └── [OutputsProtocol].swift             // Example: FirstOutputsProtocol
│   │   │   └── Views
│   │   │       └── [ScreenView].swift
│   │   └── [OtherScreens]                                  // Additional screens within the component
│
├── Extensions  
│   ├── Publisher+Bindings.swift                            // Extension for mapping and binding Combine publishers
│   └── View+Bindings.swift                                 // Extension for binding Combine publishers to SwiftUI state
│
└── Tests
    ├── Components
    │   ├── [ComponentName]                                 // Example: FirstComponent
    │   │   └── [TestFile].swift                            // Example: FirstViewModelTests.swift
    │   └── [Other Components]                              // Tests for other components
    └── TestUtilities
        └── [Mock Implementations and Helpers]
```

## Key Concepts

### MVVM+C Architecture

- **Model**: Represents the data and business logic.
- **View**: SwiftUI Views for UI representation.
- **ViewModel**: Handles data transformation and business logic for the View.
- **Coordinator**: Manages navigation and screen flow.

### Testing Strategy

- **Unit Tests**: Focus on testing individual components (ViewModels, Coordinators) in isolation.
- **Mocking & Stubbing**: Use mock objects and stubs to simulate dependencies.
- **Combine Testing**: Validate `Publisher` and `Subscriber` interactions.
- **Edge Cases**: Cover a wide range of scenarios (especially non-happy paths) to ensure robustness.

## How a View is Structured

Each `View` in this codebase adheres to a consistent structure that ensures readability, modularity, and adherence to the MVVM+C architecture. Below is an example showcasing how the `FirstView` is implemented.

### Example: `FirstView`

```swift
struct FirstView: View {
    let viewModel: FirstViewModel<FirstComponentCoordinator>
    
    @State private var displayedValue = ""
    @State private var showSheet = false
    @State private var showFullScreenCover = false

    var body: some View {
        VStack {
            Text(self.displayedValue)
            
            Button(action: {
                self.viewModel.inputs.inputSubject.send()
            }) {
                Text("Tap Me")
            }
            
            Button("Next Screen") {
                self.viewModel.inputs.navigateSubject.send()
            }
        }
        // Outputs
        .bindPublisher(self.viewModel.outputs.outputSubject, to: self.$displayedValue)
        .bindPublisher(self.viewModel.outputs.showModalView, to: self.$showSheet)
        // Navigation handler
        .handleNavigation(
            viewModel: self.viewModel,
            showSheet: self.$showSheet,
            showFullScreenCover: self.$showFullScreenCover
        )
    }
}

private extension View {
    func handleNavigation(
        viewModel: FirstViewModel<FirstComponentCoordinator>,
        showSheet: Binding<Bool>,
        showFullScreenCover: Binding<Bool>
    ) -> some View {
        self
            .navigationDestination(for: FirstComponentCoordinator.Route.self) { destination in
                viewModel.destinationContent(for: destination)
            }
            .sheet(isPresented: showSheet) {
                viewModel.bottomSheetContent()
            }
            .fullScreenCover(isPresented: showFullScreenCover) {
                viewModel.fullScreenContent()
            }
    }
}

```
### Key Sections in a View

1. **State Management**:
   - Use `@State` for local UI-related state variables (e.g., `displayedValue`, `showSheet`).

2. **Bindings to ViewModel Outputs**:
   - Use `.bindPublisher()` custom function (available on `View+Bindings.swift`) to reactively bind Combine publishers from the `ViewModel`'s outputs to `@State` variables in the `View`.

3. **Navigation Handling**:
   - Use `.handleNavigation()` custom function to abstract and manage navigation logic via the `Coordinator`.
   - To keep navigation logic separate from the main `View`, create a private extension for reusable and clean code.

  
## How a ViewModel is Structured

Each `ViewModel` should act as the bridge between the `View` and the application's business logic. It handles input from the `View`, processes data, and exposes reactive outputs that the `View` observes. Below is an example showcasing how the `FirstViewModel` is implemented.

### Example: `FirstViewModel`

```swift
final class FirstViewModel<ComponentCoordinator: FirstComponentCoordinatorProtocol>
where ComponentCoordinator.Destination == FirstComponentCoordinator.Route {
    
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
            }
            .store(in: &self.cancellables)
    }
}

// Coordinator wrappers
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
```

### Key Sections in a ViewModel

1. **Inputs**:
   - Defined as a struct conforming to `FirstInputsProtocol`, these represent the `View`'s actions and events.
   - Inputs use `Combine`'s `PassthroughSubject` to handle events reactively.

2. **Outputs**:
   - Defined as a struct conforming to `FirstOutputsProtocol`, these expose reactive state and events for the `View` to observe.
   - Outputs use `PassthroughSubject` to emit values like UI updates, or navigation destinations.

3. **Dependencies**:
   - The `Dependencies` struct encapsulates external dependencies, such as the `Coordinator`.
   - This allows for easy dependency injection and improved testability.

4. **Coordinator Integration**:
   - The `ViewModel` holds a reference to its associated `Coordinator`, which handles navigation logic.

5. **Reactive Bindings**:
   - The `bindInputs` method connects the `Inputs` to corresponding outputs or coordinator actions using `Combine`.
   - All subscriptions are stored in the `cancellables` set to manage memory effectively.

6. **Coordinator Wrappers**:
   - Additional methods provide `View`-specific content for navigation destinations, modal views, and full-screen presentations.

---
