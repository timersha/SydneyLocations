import SwiftUI

struct AddLocationInfoItem: ViewGeneratable {
    let id = UUID()
    let placeholder: String
    let text: Binding<String>
    
    // MARK: - ViewGeneratable
    
    func view() -> AnyView {
        AddLocationInfoItemView(model: self).anyView()
    }
}
