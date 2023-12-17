import Foundation

protocol MapCoordinatable: Coordinatable {}

final class MapCoordinator {
    var childCoordinators = [String: Coordinatable]()
    private let appRouter: AppRouterable
    var router: MapRouterable
    private let onFinish: OnFinishFlow
    
    init(
        appRouter: AppRouterable,
        router: MapRouterable,
        onFinish: @escaping OnFinishFlow
    ) {
        self.appRouter = appRouter
        self.router = router
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
    func addLocation() {
        router.showAddLocation(delegate: self)
    }
    
    func showLocationsList() {
        router.showLocationsList()
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

// MARK: - AddLocationDelegate

extension MapCoordinator: AddLocationDelegate {
    func onCancelTap() {
        router.dismissFullCover()
    }
}

// MARK: - LocationInfoViewModelDelegate

extension MapCoordinator: LocationInfoViewModelDelegate {
    func onCloseTap() {
        router.dismissSheet()
    }
}
