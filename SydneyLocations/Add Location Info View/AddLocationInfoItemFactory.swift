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
        [
            AddLocationInfoItem(
                placeholder: "Location name",
                text: Binding(get: { delegate.name }, set: { delegate.name = $0 })
            ),
            AddLocationInfoItem(
                placeholder: "Location description",
                text: Binding(get: { delegate.description }, set: { delegate.description = $0 })
            )
        ]
    }
}
