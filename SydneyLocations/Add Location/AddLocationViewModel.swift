import Foundation
import MapKit
import SwiftUI

protocol AddLocationViewProtocol: ObservableObject {
    var interactionModes: MapInteractionModes { get set }
    var showsUserLocation: Bool { get set }
    
    func addLocation()
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
}
