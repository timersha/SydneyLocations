import SwiftUI

protocol AddLocationInfoItemFactoryProtocol {
    static func makeItems(
        delegate: any AddLocationInfoItemDelegate
    ) -> [any ViewGeneratable]
}

enum AddLocationInfoItemFactory {}

// MARK: - AddLocationInfoItemFactoryProtocol

extension AddLocationInfoItemFactory: AddLocationInfoItemFactoryProtocol {
    static func makeItems(
        delegate: any AddLocationInfoItemDelegate
    ) -> [any ViewGeneratable] {
        
        let nameItem = AddLocationInfoItem(
            text: delegate.name,
            placeholder: "Location name"
        )
        
        delegate.bindedName = nameItem.bindedText
        
        let descriptionItem = AddLocationInfoItem(
            text: delegate.description,
            placeholder: "Location description"
        )
        delegate.bindedDescription = descriptionItem.bindedText
        return [nameItem, descriptionItem]
    }
}
