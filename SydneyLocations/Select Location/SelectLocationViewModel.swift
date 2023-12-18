import Foundation
import MapKit
import SwiftUI

protocol SelectLocationViewProtocol: ObservableObject {
    var interactionModes: MapInteractionModes { get set }
    var showsUserLocation: Bool { get set }
    
    func onNextTap()
    func onCancelTap()
    func onRegionUpdate(region: MKCoordinateRegion)
}

protocol SelectLocationDelegate: AnyObject {
    func onNextTap(location: SelectedLocation)
    func onCancelTap()
}

final class SelectLocationViewModel {
    @Published var interactionModes: MapInteractionModes =  .all
    @Published var showsUserLocation: Bool = false
    @Published var places: [MapPlace] = [.Sydney]
    weak var delegate: SelectLocationDelegate?
    private var selectedRegion: MKCoordinateRegion
    
    init(
        selectedRegion: MKCoordinateRegion,
        delegate: SelectLocationDelegate? = nil
    ) {
        self.selectedRegion = selectedRegion
        self.delegate = delegate
    }
}

// MARK: - SelectLocationViewProtocol

extension SelectLocationViewModel: SelectLocationViewProtocol {
    func onNextTap() {
        let location = SelectedLocation(region: selectedRegion)
        delegate?.onNextTap(location: location)
    }
    
    func onCancelTap() {
        delegate?.onCancelTap()
    }
    
    func onRegionUpdate(region: MKCoordinateRegion) {
        selectedRegion = region
    }
}
