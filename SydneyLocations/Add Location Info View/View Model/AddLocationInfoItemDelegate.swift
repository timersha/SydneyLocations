import Foundation
import SwiftUI

protocol AddLocationInfoItemDelegate: ObservableObject {
    var name: String { get set }
    var description: String { get set }
    
    var bindedName: Binding<String>? { get set }
    var bindedDescription: Binding<String>? { get set }
}
