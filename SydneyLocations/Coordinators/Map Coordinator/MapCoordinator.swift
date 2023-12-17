import Foundation

protocol MapCoordinatable: Coordinatable {
    
}

final class MapCoordinator {
    var childCoordinators = [String: Coordinatable]()
    private let appRouter: AppRouterable
    private let router: MapRouterable
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
