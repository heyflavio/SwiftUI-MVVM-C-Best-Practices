//
//  View+Bindable.swift
//  TestApp
//
//  Created by Flavio Kruger on 21/11/24.
//

import SwiftUICore
import Combine

extension View {
    
    func bindPublisher<P: Publisher>(
        _ publisher: P,
        to binding: Binding<P.Output>
    ) -> some View where P.Failure == Never {
        self.onReceive(publisher.receive(on: DispatchQueue.main)) { newValue in
            binding.wrappedValue = newValue
        }
    }
    
}
