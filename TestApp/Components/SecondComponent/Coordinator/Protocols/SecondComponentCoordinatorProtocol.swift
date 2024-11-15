//
//  ComponentCoordinatorProtocol.swift
//  TestApp
//
//  Created by Flavio Kruger on 15/11/24.
//

import Combine
import SwiftUICore

protocol SecondComponentCoordinatorProtocol: ObservableObject {
    associatedtype Destination: Hashable
    associatedtype ContentView: View

    var showModalView: PassthroughSubject<Bool, Never> { get }
    
    func navigate(to destination: Destination)
    func pop()
    func view(for route: Destination) -> ContentView
}
