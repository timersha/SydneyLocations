import Foundation
@testable import SydneyLocations

final class LocationInfoViewModelDelegateMock: LocationInfoViewModelDelegate {
    
    var isOnSaveTapCalled: Bool = false
    
    func onSaveTap(
        locationInfo: SydneyLocations.LocationInfo,
        saveCompletion: @escaping () -> Void
    ) {
        isOnSaveTapCalled = true
        saveCompletion()
    }
}
