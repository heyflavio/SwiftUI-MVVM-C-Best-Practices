import Combine

protocol ThirdOutputsProtocol {
    var outputSubject: PassthroughSubject<String, Never> { get }
    var showModalView: PassthroughSubject<Bool, Never> { get }
    var dismissCurrentModalView: PassthroughSubject<Bool, Never> { get }
}
