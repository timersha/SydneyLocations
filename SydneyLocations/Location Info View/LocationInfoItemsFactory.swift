import Foundation

protocol LocationInfoItemsFactoryProtocol {
    static func makeInofItems(
        model: LocationInfo,
        delegate: LocationInfoItemDelegate
    ) -> [any ViewGeneratable]
}

enum LocationInfoItemsFactory {}
    
// MARK: - LocationInfoItemsFactoryProtocol

extension LocationInfoItemsFactory: LocationInfoItemsFactoryProtocol {

    static func makeInofItems(
        model: LocationInfo,
        delegate: LocationInfoItemDelegate
    ) -> [any ViewGeneratable] {
        [
            LocationInfoItem(text: model.name) {
                delegate.didTapOn(item: model, type: .name)
            },
            LocationInfoItem(text: "lat: \(model.lat)") {
                delegate.didTapOn(item: model, type: .lat)
            },
            LocationInfoItem(text: "lon: \(model.lon)") {
                delegate.didTapOn(item: model, type: .lon)
            },
            LocationInfoItem(text: "description: \(model.description)") {
                delegate.didTapOn(item: model, type: .description)
            }
        ]
    }
}

enum LocationInfoItemType {
    case name
    case lat
    case lon
    case description
}
