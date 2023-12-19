import Foundation

protocol LocationsItemsFactoryProtocol {
    static func makeLocationItems(
        models: [Location],
        delegate: LocationsViewItemsDelegate
    ) -> [any ViewGeneratable]
}

enum LocationsItemsFactory {}

// MARK: - LocationsItemsFactoryProtocol

extension LocationsItemsFactory: LocationsItemsFactoryProtocol {
    static func makeLocationItems(
        models: [Location],
        delegate: LocationsViewItemsDelegate
    ) -> [any ViewGeneratable] {
        models.map { location in
            LocationItem(name: location.name) {
                delegate.didTapItem(model: location)
            }
        }
    }
}
