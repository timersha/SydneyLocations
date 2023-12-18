import Combine
import Foundation
import SwiftUI

protocol AddLocationInfoItemDelegate: ObservableObject {
    var name: String { get set }
    var description: String { get set }
    
    var namePublisher: AnyPublisher<String,Never>? { get set }
    var descriptionPublisher: AnyPublisher<String,Never>? { get set }
}
