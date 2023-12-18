import Foundation
import MapKit
import SwiftUI

final class MapViewModel {
    var region: MKCoordinateRegion
    @Published var interactionModes: MapInteractionModes =  .all
    @Published var showsUserLocation: Bool = false
    @Published var place: MapPlace = .Sydney
    @Published var places: [MapPlace] = [.Sydney]
    private let factory: MapItemsFactoryProtocol.Type
    private let fileService: FileServiceProtocol.Type
    private let parser: Parsable.Type
    private weak var delegate: MapViewModelDelegate?
    
    init(
        region: MKCoordinateRegion,
        delegate: MapViewModelDelegate? = nil,
        fileService: FileServiceProtocol.Type = FileService.self,
        factory: MapItemsFactoryProtocol.Type = MapItemsFactory.self,
        parser: Parsable.Type = ParserService.self
    ) {
        self.region = region
        self.delegate = delegate
        self.factory = factory
        self.fileService = fileService
        self.parser = parser
        readPlaces()
    }
    
    private func readPlaces() {
        guard let locationsData: Data = fileService.defaultLocationsData(),
              let locations = parser.parse(data: locationsData, to: Locations.self),
              let itemLocations: [Location] = locations.locations else {
            return
        }
        
        let mapPlaces = factory.makeMapItems(models: itemLocations)
        places = mapPlaces
    }
}

// MARK: - MapViewModelProtocol

extension MapViewModel: MapViewModelProtocol {
    func createLocation() {
        delegate?.createLocation()
    }

    func showList() {
        delegate?.showLocationsList()
    }

    func didTapAnnotation(place: MapPlace) {
        delegate?.showLocationDetails(place: place)
    }
}
