import SwiftUI

class AddLocationInfoItem: ViewGeneratable, ObservableObject {
    let id = UUID()
    let placeholder: String
    lazy var bindedText: Binding<String> = Binding(get: { self.text }, set: { self.text = $0 })
    @Published var text: String
    
    init(
        text: String,
        placeholder: String
    ) {
        self.text = text
        self.placeholder = placeholder
    }
    
    // MARK: - ViewGeneratable
    
    func view(proxy: ScrollViewProxy) -> AnyView {
        AddLocationInfoItemView(model: self, proxy: proxy).anyView()
    }
}
