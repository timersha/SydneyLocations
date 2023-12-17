import SwiftUI

protocol AddLocationInfoViewModelProtocol: ObservableObject {
    var displayItems: [any ViewGeneratable] { get set }
    
    func onSaveTap()
}

protocol AddLocationInfoItemDelegate: ObservableObject {
    var name: String { get set }
    var description: String { get set }
}

final class AddLocationInfoViewModel: AddLocationInfoItemDelegate {
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var displayItems = [any ViewGeneratable]()
    private let factory: AddLocationInfoItemFactoryProtocol.Type
    
    init(
        factory: AddLocationInfoItemFactoryProtocol.Type = AddLocationInfoItemFactory.self
    ) {
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
        debugPrint("onSaveTap name: \(name) description: \(description)")
    }
}
