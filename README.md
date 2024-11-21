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

This project serves as an **abstraction** of a real-life application, providing a simplified yet scalable structure for modular development. The project is organized into two main sections: `ApplicationRoot` and `Components`. 

- The `ApplicationRoot` handles the overall application lifecycle and navigation setup through the root coordinator. 
- The `Components` folder follows a feature-based modular structure, where each component contains its own `Coordinator` and one or more `Screens`. Each screen consists of its own `View`, `ViewModel`, and associated protocols for `Input` and `Output` interactions.

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
