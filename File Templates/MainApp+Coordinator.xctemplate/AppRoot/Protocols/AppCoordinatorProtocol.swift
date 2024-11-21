import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    
    func navigate(to destination: any Hashable)
    func pop()
}
