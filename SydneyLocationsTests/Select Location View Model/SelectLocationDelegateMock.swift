import Foundation
@testable import SydneyLocations

final class SelectLocationDelegateMock: SelectLocationDelegate {
    
    var isOnNextTapCalled: Bool = false
    var isOnCancelTapCalled: Bool = false
    
    func onNextTap(location: SelectedLocation) {
        isOnNextTapCalled = true
    }
    
    func onCancelTap() {
        isOnCancelTapCalled = true
    }
}
