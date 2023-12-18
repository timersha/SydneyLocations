import Foundation

protocol MapCoordinatable: Coordinatable {}

final class MapCoordinator {
    var childCoordinators = [String: Coordinatable]()
    private let appRouter: AppRouterable
    var router: MapRouterable
    private let factory: CoordinatorsFactoryProtocol.Type
    private let onFinish: OnFinishFlow
    
    init(
        appRouter: AppRouterable,
        router: MapRouterable,
        factory: CoordinatorsFactoryProtocol.Type = CoordinatorsFactory.self,
        onFinish: @escaping OnFinishFlow
    ) {
        self.appRouter = appRouter
        self.router = router
        self.factory = factory
        self.onFinish = onFinish
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
    func createLocation() {
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
        }
        add(childCoordinator: createLocationCoordinator)
        createLocationCoordinator.start()
    }
    
    func showLocationsList() {
        router.showLocationsList(delegate: self)
    }
    
    func showLocationDetails(place: MapPlace) {
        let model = LocationInfo(
            name: place.name,
            lat: place.latitude,
            lon: place.longitude,
            description: ""
        )
        router.showLocationDetails(model: model, delegate: self)
    }
}

// MARK: - LocationInfoViewModelDelegate

extension MapCoordinator: LocationInfoViewModelDelegate {
    func onCloseTap() {
        router.dismissSheet()
    }
}

// MARK: - LocationsViewItemsDelegate

extension MapCoordinator: LocationsViewItemsDelegate {
    func didTapItem(model: Location) {
        let model = LocationInfo(
            name: model.name,
            lat: model.latitude,
            lon: model.longitude,
            description: ""
        )
        router.showLocationDetails(model: model, delegate: self)
    }
}
