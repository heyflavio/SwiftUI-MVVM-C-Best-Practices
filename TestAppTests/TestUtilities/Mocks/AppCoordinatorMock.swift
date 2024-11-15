//
//  MockAppCoordinator.swift
//  TestAppTests
//
//  Created by Flavio Kruger on 15/11/24.
//

@testable import TestApp

class AppCoordinatorMock: AppCoordinator {
    
    var lastNavigatedRoute: FirstComponentCoordinator.Route?
    var didPop = false
    
    override func navigate(to destination: any Hashable) {
        guard let route = destination as? FirstComponentCoordinator.Route else {
            return
        }
        self.lastNavigatedRoute = route
    }
    
    override func pop() {
        self.didPop = true
    }
}
