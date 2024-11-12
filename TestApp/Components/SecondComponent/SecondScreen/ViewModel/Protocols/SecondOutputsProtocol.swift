import Combine

protocol SecondOutputsProtocol {
    var outputSubject: PassthroughSubject<String, Never> { get }
    var showModalView: PassthroughSubject<Bool, Never> { get }
}
