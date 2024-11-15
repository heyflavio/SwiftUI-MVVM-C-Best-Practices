//
//  ComponentCoordinatorProtocol.swift
//  TestApp
//
//  Created by Flavio Kruger on 15/11/24.
//

import Combine
import SwiftUICore

protocol FirstComponentCoordinatorProtocol: ObservableObject {
    associatedtype Destination: Hashable
    associatedtype ContentView: View
    
    func navigate(to destination: Destination)
    func pop()
    func view(for route: Destination) -> ContentView
}
