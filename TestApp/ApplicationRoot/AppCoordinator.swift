//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Flavio Kruger on 13/10/24.
//

import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    
    func navigate(to destination: any Hashable)
    func pop()
}

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

