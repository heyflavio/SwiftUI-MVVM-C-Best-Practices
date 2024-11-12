import XCTest
@testable import TestApp

class FirstComponentCoordinatorTests: XCTestCase {
    
    var appCoordinator: MockAppCoordinator!
    var firstComponentCoordinator: FirstComponentCoordinator!
    
    override func setUp() {
        super.setUp()
        appCoordinator = MockAppCoordinator()
        firstComponentCoordinator = FirstComponentCoordinator(appCoordinator: appCoordinator)
    }
    
    override func tearDown() {
        firstComponentCoordinator = nil
        appCoordinator = nil
        super.tearDown()
    }
    
    func testNavigateToDefaultRoute() {
        firstComponentCoordinator.navigate(to: .default)
        XCTAssertEqual(appCoordinator.lastNavigatedRoute, .default)
    }
    
    func testPop() {
        firstComponentCoordinator.pop()
        XCTAssertTrue(appCoordinator.didPop)
    }
    
    func testViewForDefaultRoute() {
        let view = firstComponentCoordinator.view(for: .default)
        XCTAssertNotNil(view)
    }
}

// Mock class for AppCoordinator
class MockAppCoordinator: AppCoordinator {
    
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
