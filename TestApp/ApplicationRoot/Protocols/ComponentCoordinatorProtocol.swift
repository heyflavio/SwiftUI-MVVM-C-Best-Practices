//
//  ComponentCoordinatorProtocol.swift
//  TestApp
//
//  Created by Flavio Kruger on 20/11/24.
//

import SwiftUICore

protocol ComponentCoordinatorProtocol: ObservableObject {
    associatedtype Destination: Hashable
    associatedtype ContentView: View
    
    func navigate(to destination: Destination)
    func pop()
    func view(for route: Destination) -> ContentView
}
