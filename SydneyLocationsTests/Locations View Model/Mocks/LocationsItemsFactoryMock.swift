import Foundation
@testable import SydneyLocations

enum LocationsItemsFactoryMock: LocationsItemsFactoryProtocol {
    
    static var isMakeLocationItemsCalled: Bool = false
    static var makeLocationItemsresult = [any SydneyLocations.ViewGeneratable]()
    
    static func makeLocationItems(
        models: [SydneyLocations.Location],
        delegate: SydneyLocations.LocationsViewItemsDelegate
    ) -> [any SydneyLocations.ViewGeneratable] {
        isMakeLocationItemsCalled = true
        return makeLocationItemsresult
    }
}
