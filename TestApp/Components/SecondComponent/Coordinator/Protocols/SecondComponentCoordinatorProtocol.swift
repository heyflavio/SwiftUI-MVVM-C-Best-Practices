//
//  ComponentCoordinatorProtocol.swift
//  TestApp
//
//  Created by Flavio Kruger on 15/11/24.
//

import Combine
import SwiftUICore

protocol SecondComponentCoordinatorProtocol: ComponentCoordinatorProtocol {
    var showModalView: PassthroughSubject<Bool, Never> { get }
}
