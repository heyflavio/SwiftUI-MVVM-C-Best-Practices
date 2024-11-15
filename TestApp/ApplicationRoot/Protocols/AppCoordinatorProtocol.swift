//
//  AppCoordinatorProtocol.swift
//  TestApp
//
//  Created by Flavio Kruger on 15/11/24.
//

import SwiftUI

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    
    func navigate(to destination: any Hashable)
    func pop()
}

