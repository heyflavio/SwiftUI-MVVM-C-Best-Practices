//
//  Publisher+Bindings.swift
//  TestApp
//
//  Created by Flavio Kruger on 21/11/24.
//

import Combine

extension Publisher where Failure == Never {

    /// Maps the publisher's output to a constant value.
    func map<T>(_ value: T) -> AnyPublisher<T, Never> {
        self.map { _ in value }.eraseToAnyPublisher()
    }
    
    /// Binds the publisher's output to a `PassthroughSubject` of the same type.
    func bind(to subject: PassthroughSubject<Output, Never>?) -> AnyCancellable {
        self.sink { subject?.send($0) }
    }
}

