import Foundation

extension Notification.Name {
    static let didUpdateLocations = Notification.Name("DidUpdateLocations")
}

protocol MapCoordinatable: Coordinatable {}

final class MapCoordinator {
    var childCoordinators = [String: Coordinatable]()
    private let appRouter: AppRouterable
    var router: MapRouterable
    private let coreDataService: CoreDataServiceProtocol
    private let factory: CoordinatorsFactoryProtocol.Type
    private let networkService: NetworkServiceProtocol
    private let onFinish: OnFinishFlow
    
    init(
        appRouter: AppRouterable,
        router: MapRouterable,
        factory: CoordinatorsFactoryProtocol.Type = CoordinatorsFactory.self,
        coreDataService: CoreDataServiceProtocol = CoreDataService.shared,
        networkService: NetworkServiceProtocol = NetworkService.shared,
        onFinish: @escaping OnFinishFlow
    ) {
        self.appRouter = appRouter
        self.router = router
        self.factory = factory
        self.coreDataService = coreDataService
        self.networkService = networkService
        self.onFinish = onFinish
        readAndSaveDefaultPlaces()
    }
    
    private func readAndSaveDefaultPlaces() {
        Task {
            
            let result = await networkService.getDefaultLocations()
            guard let locations: Locations = result.model,
                  let defaultLocations: [Location] = locations.locations else {
                return
            }
            
            await withTaskGroup(of: Void.self) { [weak self] group in
                guard let self = self else { return }
                
                let locations = await coreDataService.getLocations()
                let locationsNames: Set<String> = locations.reduce(into: Set<String>()) { $0.insert($1.name) }
                
                defaultLocations.forEach { dLocation in
                    if !locationsNames.contains(dLocation.name) {
                        group.addTask {
                            await self.coreDataService.create(location: dLocation)
                        }
                    }
                }
                
                await group.waitForAll()
                
                NotificationCenter.default.post(
                    name: .didUpdateLocations,
                    object: nil
                )
            }
            
        }
    }
}

// MARK: - MapCoordinatable

extension MapCoordinator: MapCoordinatable {
    func start () {
        appRouter.instantiateRoot(view: router.rootView)
    }
}

// MARK: - MapViewModelDelegate

extension MapCoordinator: MapViewModelDelegate {
    func createLocation(didAddLocation: @escaping () -> Void) {
        let rootRouterState = RootRouterState(
            path: router.routePath(),
            presentedItem: router.presentedItem(),
            fullCoverItem: router.fullCoverItem()
        )
        let createLocationCoordinator = factory.makeCreateLocationCoordinator(
            rootRouterState: rootRouterState
        ) { [weak self] coordinator in
            guard let self = self else { return }
            self.remove(childCoordinator: coordinator)
            didAddLocation()
        }
        add(childCoordinator: createLocationCoordinator)
        createLocationCoordinator.start()
    }
    
    func showLocationsList() {
        router.showLocationsList(delegate: self)
    }
    
    func showLocationDetails(place: MapPlace) {
        let model = LocationInfo(
            id: place.id,
            name: place.name,
            latitude: place.latitude,
            longitude: place.longitude,
            description: place.description ?? ""
        )
        router.showLocationDetails(model: model, delegate: self)
    }
}

// MARK: - LocationInfoViewModelDelegate

extension MapCoordinator: LocationInfoViewModelDelegate {
    func onSaveTap(
        locationInfo: LocationInfo,
        saveCompletion: @escaping () -> Void
    ) {
        Task {
            let location = Location(
                id: locationInfo.id,
                name: locationInfo.name,
                latitude: locationInfo.latitude,
                longitude: locationInfo.longitude,
                descriptionText: locationInfo.description
            )
            await coreDataService.update(location: location)
            await MainActor.run {
                saveCompletion()
                NotificationCenter.default.post(
                    name: .didUpdateLocations,
                    object: nil
                )
            }
        }
    }
}

// MARK: - LocationsViewItemsDelegate

extension MapCoordinator: LocationsViewItemsDelegate {
    func didTapItem(model: Location) {
        let model = LocationInfo(
            id: model.id ?? UUID(),
            name: model.name,
            latitude: model.latitude,
            longitude: model.longitude,
            description: model.descriptionText ?? ""
        )
        router.showLocationDetails(model: model, delegate: self)
    }
}
