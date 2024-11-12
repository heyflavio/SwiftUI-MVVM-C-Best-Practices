import Combine

protocol FirstInputsProtocol {
    var inputSubject: PassthroughSubject<Void, Never> { get }
    var navigateSubject: PassthroughSubject<Void, Never> { get }
}
