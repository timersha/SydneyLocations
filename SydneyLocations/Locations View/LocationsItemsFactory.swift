import Foundation

protocol LocationsItemsFactoryProtocol {
    static func makeLocationItems(
        models: [Location],
        delegate: LocationsViewItemsDelegate
    ) -> [LocationItem]
}

enum LocationsItemsFactory {}

// MARK: - LocationsItemsFactoryProtocol

extension LocationsItemsFactory: LocationsItemsFactoryProtocol {
    static func makeLocationItems(
        models: [Location],
        delegate: LocationsViewItemsDelegate
    ) -> [LocationItem] {
        models.map { location in
            LocationItem(name: location.name) {
                delegate.didTapItem(model: location)
            }
        }
    }
}
