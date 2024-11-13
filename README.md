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

```plaintext
TestApp
│
├── ApplicationRoot
│   ├── AppCoordinator.swift        // Root coordinator managing app flow
│   ├── AppDelegate.swift           // App lifecycle (if required)
│   └── TestAppApp.swift            // SwiftUI App entry point
│
├── Components                      // Modular feature-based components
│   ├── [ComponentName]             // Example: FirstComponent
│   │   ├── Coordinator
│   │   │   └── [ComponentCoordinator].swift
│   │   ├── [ScreenName]            // Example: FirstScreen
│   │   │   ├── ViewModel
│   │   │   │   ├── [ScreenViewModel].swift
│   │   │   │   └── Protocols       // Protocol definitions for ViewModel
│   │   │   └── Views
│   │   │       └── [ScreenView].swift
│   │   └── [OtherScreens]          // Additional screens within the component
│
└── Tests
    ├── Components
    │   ├── [ComponentName]         // Example: FirstComponent
    │   │   └── [TestFile].swift    // Example: FirstComponentCoordinatorTests.swift
    │   └── [Other Components]      // Tests for other components
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
