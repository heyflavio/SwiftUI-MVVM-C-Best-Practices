import XCTest
@testable import TestApp

class FirstComponentCoordinatorTests: XCTestCase {
    
    var appCoordinator: AppCoordinatorMock!
    var firstComponentCoordinator: FirstComponentCoordinator!
    
    override func setUp() {
        super.setUp()
        appCoordinator = AppCoordinatorMock()
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
