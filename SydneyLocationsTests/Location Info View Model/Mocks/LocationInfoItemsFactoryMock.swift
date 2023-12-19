import Foundation
@testable import SydneyLocations

enum LocationInfoItemsFactoryMock: LocationInfoItemsFactoryProtocol {
    
    static var isMakeInofItemsCalled: Bool = false
    static var makeInofItemsResult = [any SydneyLocations.ViewGeneratable]()
    
    static func makeInofItems(
        model: SydneyLocations.LocationInfo,
        delegate: SydneyLocations.LocationInfoItemDelegate
    ) -> [any SydneyLocations.ViewGeneratable] {
        isMakeInofItemsCalled = true
        return makeInofItemsResult
    }
}

