import Foundation
@testable import SydneyLocations

final class AddLocationInfoDelegateMock: AddLocationInfoDelegate {
    
    var isOnSaveTapCalled: Bool = false
    
    func onSaveTap(
        name: String,
        description: String,
        saveCompletion: @escaping () -> Void
    ) {
        isOnSaveTapCalled = true
        saveCompletion()
    }
}
