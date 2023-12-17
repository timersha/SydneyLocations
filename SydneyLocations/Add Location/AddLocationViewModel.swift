import Foundation
import MapKit
import SwiftUI

protocol AddLocationViewProtocol: ObservableObject {
    var interactionModes: MapInteractionModes { get set }
    var showsUserLocation: Bool { get set }
    
    func onNextTap()
    func onCancelTap()
    func onRegionUpdate(region: MKCoordinateRegion)
}

protocol AddLocationDelegate: AnyObject {
    func onCancelTap()
}

final class AddLocationViewModel {
    @Published var interactionModes: MapInteractionModes =  .all
    @Published var showsUserLocation: Bool = false
    @Published var places: [MapPlace] = [.Sydney]
    weak var delegate: AddLocationDelegate?
    
    init(delegate: AddLocationDelegate?) {
        self.delegate = delegate
    }
}

// MARK: - AddLocationViewProtocol

extension AddLocationViewModel: AddLocationViewProtocol {
    func onNextTap() {
        debugPrint("onNextTap")
    }
    
    func onCancelTap() {
        delegate?.onCancelTap()
    }
    
    func onRegionUpdate(region: MKCoordinateRegion) {
        debugPrint("new location: \(region.center.latitude) \(region.center.longitude)")
    }
}
