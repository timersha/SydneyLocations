import Foundation

final class LocationsViewModel {
    @Published var displayItems = [any ViewGeneratable]()
    private var locationsDTOs = [Location]()
    private let factory: LocationsItemsFactoryProtocol.Type
    private let coreDataService: CoreDataServiceProtocol
    private var notificationToken: NSObjectProtocol?
    weak var delegate: LocationsViewItemsDelegate?
    
    
    init(
        delegate: LocationsViewItemsDelegate? = nil,
        coreDataService: CoreDataServiceProtocol = CoreDataService.shared,
        factory: LocationsItemsFactoryProtocol.Type = LocationsItemsFactory.self
    ) {
        self.delegate = delegate
        self.coreDataService = coreDataService
        self.factory = factory
        readLocations()
        subscribeToNotifications()
    }
    
    deinit {
        if let observer = notificationToken {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func subscribeToNotifications() {
        // TODO: Create notification center service
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
            self.locationsDTOs = locations
            let sLocations = factory.makeLocationItems(models: locations, delegate: self)
            await MainActor.run {
                displayItems = sLocations
            }
        }
    }
}

// MARK: - LocationsViewModelProtocol

extension LocationsViewModel: LocationsViewModelProtocol {
    func onLocationAppear(model: any ViewGeneratable) {}
    
    func onAppear() {
        readLocations()
    }
    
    func onDeleteItems(indexes: IndexSet) {
        indexes.forEach {
            guard let location: Location = locationsDTOs[safe: $0],
                  let locationId = location.id else {
                return
            }
            Task {
                await coreDataService.deleteLocation(byId: locationId)
            }
        }
    }
}

// MARK: - LocationsViewItemsDelegate

extension LocationsViewModel: LocationsViewItemsDelegate {
    func didTapItem(model: Location) {
        delegate?.didTapItem(model: model)
    }
}
