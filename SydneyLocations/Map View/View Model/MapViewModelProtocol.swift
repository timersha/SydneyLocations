import Foundation
import MapKit
import SwiftUI

protocol MapViewModelProtocol: ObservableObject {
    var region: MKCoordinateRegion { get set }
    var interactionModes: MapInteractionModes { get set }
    var showsUserLocation: Bool { get set }
    var place: MapPlace { get set }
    var places: [MapPlace] { get set }
    
    func showList()
    func addLocation()
    func didTapAnnotation(place: MapPlace)
}
