import Foundation
import MapKit
import SwiftUI

protocol AddLocationViewProtocol: ObservableObject {
    var interactionModes: MapInteractionModes { get set }
    var showsUserLocation: Bool { get set }
    
    func addLocation()
    func onCancelTap()
    func onRegionUpdate(region: MKCoordinateRegion)
}

final class AddLocationViewModel {
    @Published var interactionModes: MapInteractionModes =  .all
    @Published var showsUserLocation: Bool = false
    @Published var places: [MapPlace] = [.Sydney]
}

// MARK: - AddLocationViewProtocol

extension AddLocationViewModel: AddLocationViewProtocol {
    func addLocation() {
        debugPrint("addLocation")
    }
    
    func onCancelTap() {
        debugPrint("onCancelTap")
    }
    
    func onRegionUpdate(region: MKCoordinateRegion) {
        debugPrint("new location: \(region.center.latitude) \(region.center.longitude)")
    }
}
