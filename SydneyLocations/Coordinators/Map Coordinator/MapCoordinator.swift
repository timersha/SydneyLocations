import Foundation

protocol MapCoordinatable: Coordinatable {
    
}

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
    
    func showLocationDetails() {
        debugPrint("showLocationDetails")
    }
}

// MARK: - AddLocationDelegate

extension MapCoordinator: AddLocationDelegate {
    func onCancelTap() {
        router.dismissFullCover()
    }
}
