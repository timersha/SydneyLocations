import Foundation
@testable import SydneyLocations

final class LocationsViewItemsDelegateMock: LocationsViewItemsDelegate {
    
    var isDidTapItemCalled: Bool = false
    
    func didTapItem(model: SydneyLocations.Location) {
        isDidTapItemCalled = true
    }
}
