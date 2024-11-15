//
//  MockComponentCoordinator.swift
//  TestAppTests
//
//  Created by Flavio Kruger on 15/11/24.
//

import XCTest
import Combine
import SwiftUICore
@testable import TestApp

class FirstComponentCoordinatorMock: FirstComponentCoordinatorProtocol {
    
    var destination: FirstComponentCoordinator.Route?
    var navigateCalled = false
    var popCalled = false

    func navigate(to route: FirstComponentCoordinator.Route) {
        self.destination = route
        self.navigateCalled = true
    }
    
    func pop() {
        self.popCalled = true
    }

    func view(for route: FirstComponentCoordinator.Route) -> AnyView {
        return AnyView(EmptyView())
    }
}
