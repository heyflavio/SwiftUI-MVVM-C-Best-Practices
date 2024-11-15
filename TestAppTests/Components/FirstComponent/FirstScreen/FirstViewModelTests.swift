//
//  FirstScreenViewModelTests.swift
//  TestAppTests
//
//  Created by Flavio Kruger on 15/11/24.
//

import XCTest
import Combine

@testable import TestApp

final class FirstViewModelTests: XCTestCase {
    private var mockCoordinator: FirstComponentCoordinatorMock!
    private var viewModel: FirstViewModel<FirstComponentCoordinatorMock>!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockCoordinator = FirstComponentCoordinatorMock()
        
        let dependencies = FirstViewModel<FirstComponentCoordinatorMock>.Dependencies(appCoordinator: mockCoordinator)
        viewModel = FirstViewModel<FirstComponentCoordinatorMock>(dependencies: dependencies)
        
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockCoordinator = nil
        cancellables = nil
        super.tearDown()
    }
    
    // Test inputSubject triggers correct output
    func testInputSubjectSendsOutput() {
        let expectation = XCTestExpectation(description: "Output subject should receive a string")

        viewModel.outputs.outputSubject
            .sink { value in
                XCTAssertEqual(value, "Text output")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.inputs.inputSubject.send(())
        
        wait(for: [expectation], timeout: 1.0)
    }

    // Test navigateSubject triggers navigation
    func testNavigateSubjectCallsCoordinator() {
        viewModel.inputs.navigateSubject.send(())

        XCTAssertTrue(mockCoordinator.navigateCalled, "Coordinator's navigate should be called")
        XCTAssertEqual(mockCoordinator.destination, .default, "Destination should be default route")
    }
    
    // Test showModalView is triggered
//    func testShowModalView() {
//        let expectation = XCTestExpectation(description: "Show modal view should be triggered")
//
//        viewModel.outputs.showModalView
//            .sink { isPresented in
//                XCTAssertTrue(isPresented)
//                expectation.fulfill()
//            }
//            .store(in: &cancellables)
//        
//        // Uncomment modal logic in bindInputs to test this
//        // viewModel.inputs.navigateSubject.send(())
//        
//        wait(for: [expectation], timeout: 1.0)
//    }
}
