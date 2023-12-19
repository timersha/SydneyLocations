import Foundation
@testable import SydneyLocations

final class MapViewModelDelegateMock: MapViewModelDelegate {
    
    var isCreateLocationCalled: Bool = false
    var isShowLocationsListCalled: Bool = false
    var isShowLocationDetails: Bool = false
    
    func createLocation(didAddLocation: @escaping () -> Void) {
        isCreateLocationCalled = true
        didAddLocation()
    }
    
    func showLocationsList() {
        isShowLocationsListCalled = true
    }
    
    func showLocationDetails(place: SydneyLocations.MapPlace) {
        isShowLocationDetails = true
    }
}
