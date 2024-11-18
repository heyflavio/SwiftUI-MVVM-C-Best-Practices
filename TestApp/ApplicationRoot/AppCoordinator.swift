//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Flavio Kruger on 13/10/24.
//

import SwiftUI

class AppCoordinator: AppCoordinatorProtocol {
    @Published var path: NavigationPath
    
    init(path: NavigationPath = NavigationPath()) {
        self.path = path
    }
    
    func navigate(to destination: any Hashable) {
        self.path.append(destination)
    }
    
    func pop() {
        guard self.path.count >= 1 else {
            return
        }
        
        self.path.removeLast()
    }
}

extension AppCoordinator {
    
    @ViewBuilder
    func rootView() -> some View {
        FirstView(viewModel: .init(
            dependencies: .init(
                coordinator: .init(appCoordinator: self))))
    }
    
}
