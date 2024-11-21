import Combine
import SwiftUICore

protocol FirstOutputsProtocol {
    var outputSubject: PassthroughSubject<String, Never> { get }
    var showModalView: PassthroughSubject<Bool, Never> { get }
}
