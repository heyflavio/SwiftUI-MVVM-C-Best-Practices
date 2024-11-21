import Combine

protocol ___VARIABLE_componentName___OutputsProtocol {
    var outputSubject: PassthroughSubject<String, Never> { get }
    var showModalView: PassthroughSubject<Bool, Never> { get }
    var dismissCurrentModalView: PassthroughSubject<Bool, Never> { get }
}
