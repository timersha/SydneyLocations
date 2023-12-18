import SwiftUI

final class AddLocationInfoViewModel: AddLocationInfoItemDelegate {
    var name: String
    var description: String
    var bindedName: Binding<String>?
    var bindedDescription: Binding<String>?
    
    @Published var displayItems = [any ViewGeneratable]()
    private let factory: AddLocationInfoItemFactoryProtocol.Type
    weak var delegate: AddLocationInfoDelegate?
    
    init(
        name: String = "",
        description: String = "",
        delegate: AddLocationInfoDelegate? = nil,
        factory: AddLocationInfoItemFactoryProtocol.Type = AddLocationInfoItemFactory.self
    ) {
        self.name = name
        self.description = description
        self.delegate = delegate
        self.factory = factory
        makeItems()
    }
    
    private func makeItems() {
        let items = factory.makeItems(delegate: self)
        displayItems = items
    }
}

// MARK: - AddLocationInfoViewModelProtocol

extension AddLocationInfoViewModel: AddLocationInfoViewModelProtocol {
    func onSaveTap() {
        debugPrint("onSaveTap name: \(bindedName?.wrappedValue) description: \(bindedDescription?.wrappedValue)")
    }
}
