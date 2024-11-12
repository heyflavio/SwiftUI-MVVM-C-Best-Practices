import Combine

protocol SecondInputsProtocol {
    var inputSubject: PassthroughSubject<Void, Never> { get }
    var navigateSubject: PassthroughSubject<Void, Never> { get }
}
