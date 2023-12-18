import Foundation
import MapKit
import SwiftUI

final class MapViewModel {
    var region: MKCoordinateRegion
    @Published var interactionModes: MapInteractionModes =  .all
    @Published var showsUserLocation: Bool = false
    @Published var place: MapPlace = .Sydney
    @Published var places: [MapPlace] = [.Sydney]
    private var defaultPlaces: [MapPlace] = []
    private var dbLocations: [MapPlace] = []
    private let factory: MapItemsFactoryProtocol.Type
    private let fileService: FileServiceProtocol.Type
    private let parser: Parsable.Type
    private weak var delegate: MapViewModelDelegate?
    private let coreDataService: CoreDataServiceProtocol
    
    init(
        region: MKCoordinateRegion,
        delegate: MapViewModelDelegate? = nil,
        coreDataService: CoreDataServiceProtocol = CoreDataService.shared,
        fileService: FileServiceProtocol.Type = FileService.self,
        factory: MapItemsFactoryProtocol.Type = MapItemsFactory.self,
        parser: Parsable.Type = ParserService.self
    ) {
        self.region = region
        self.delegate = delegate
        self.coreDataService = coreDataService
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
        defaultPlaces = mapPlaces
        updateDislplayPlaces()
    }
    
    private func readLocations() {
        Task {
            let locations: [Location] = await coreDataService.getLocations()
            let sLocations = factory.makeMapItems(models: locations)
            dbLocations = sLocations
            
            await MainActor.run {
                updateDislplayPlaces()
            }
        }
    }
    
    private func updateDislplayPlaces() {
        places = defaultPlaces + dbLocations
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
