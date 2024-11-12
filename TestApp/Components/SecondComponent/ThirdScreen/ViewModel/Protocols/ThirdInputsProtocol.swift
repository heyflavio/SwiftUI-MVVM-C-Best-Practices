import Combine

protocol ThirdInputsProtocol {
    var inputSubject: PassthroughSubject<Void, Never> { get }
    var navigateSubject: PassthroughSubject<Void, Never> { get }
}
