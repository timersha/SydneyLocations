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
    func didTapAnnotation()
}

final class MapViewModel {
    var region: MKCoordinateRegion
    @Published var interactionModes: MapInteractionModes =  .all
    @Published var showsUserLocation: Bool = false
    @Published var place: MapPlace = .Sydney
    @Published var places: [MapPlace] = [.Sydney]
    private let factory: MapItemsFactoryProtocol.Type
    private let fileService: FileServiceProtocol.Type
    private let parser: Parsable.Type
    
    init(
        region: MKCoordinateRegion,
        fileService: FileServiceProtocol.Type = FileService.self,
        factory: MapItemsFactoryProtocol.Type = MapItemsFactory.self,
        parser: Parsable.Type = ParserService.self
    ) {
        self.region = region
        self.factory = factory
        self.fileService = fileService
        self.parser = parser
        readPlaces()
    }
    
    private func readPlaces() {
        guard let locationsData: Data = fileService.getLocationsData(),
              let locations = parser.parse(data: locationsData, to: Locations.self),
              let itemLocations: [Location] = locations.locations else {
            return
        }
        debugPrint("locations: \(locations)")
        debugPrint("locations")
        
        let mapPlaces = factory.makeMapItems(models: itemLocations)
        debugPrint("mapPlaces: \(mapPlaces)")
        debugPrint("mapPlaces")
        places = mapPlaces
    }
}

// MARK: - MapViewModelProtocol

extension MapViewModel: MapViewModelProtocol {
    func addLocation() {
        debugPrint("Add Location Did Tap")
    }

    func showList() {
        debugPrint("Show List Did Tap")
    }

    func didTapAnnotation() {
        debugPrint("Annotation Did Tap")
    }
}
