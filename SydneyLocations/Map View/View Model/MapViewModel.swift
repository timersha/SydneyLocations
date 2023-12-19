import Foundation
import MapKit
import SwiftUI

final class MapViewModel {
    var region: MKCoordinateRegion
    @Published var interactionModes: MapInteractionModes =  .all
    @Published var showsUserLocation: Bool = false
    @Published var place: MapPlace = .Sydney
    @Published var places: [MapPlace] = [.Sydney]
    private var notificationToken: NSObjectProtocol?
    private let factory: MapItemsFactoryProtocol.Type
    private weak var delegate: MapViewModelDelegate?
    private let coreDataService: CoreDataServiceProtocol
    
    init(
        region: MKCoordinateRegion,
        delegate: MapViewModelDelegate? = nil,
        coreDataService: CoreDataServiceProtocol = CoreDataService.shared,
        factory: MapItemsFactoryProtocol.Type = MapItemsFactory.self
    ) {
        self.region = region
        self.delegate = delegate
        self.coreDataService = coreDataService
        self.factory = factory
        subscribeToNotifications()
    }
    
    deinit {
        if let observer = notificationToken {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func subscribeToNotifications() {
        notificationToken = NotificationCenter.default.addObserver(
            forName: .didUpdateLocations,
            object: nil,
            queue: nil
        ) { [weak self] note in
            guard let self = self else { return }
            self.readLocations()
        }
    }
    
    private func readLocations() {
        Task {
            let locations: [Location] = await coreDataService.getLocations()
            let sLocations = factory.makeMapItems(models: locations)
            
            await MainActor.run {
                places = sLocations
            }
        }
    }
}

// MARK: - MapViewModelProtocol

extension MapViewModel: MapViewModelProtocol {
    func createLocation() {
        delegate?.createLocation { [weak self] in
            self?.readLocations()
        }
    }

    func showList() {
        delegate?.showLocationsList()
    }

    func didTapAnnotation(place: MapPlace) {
        delegate?.showLocationDetails(place: place)
    }
    
    func onAppear() {
        readLocations()
    }
}
