import Foundation

final class CreateLocationCoordinator {
    var childCoordinators = [String: Coordinatable]()
    var router: CreateLocationRouterable
    private let rootRouter: CreateLocationRootRouterable
    private let onFinish: OnFinishFlow
    private var selectedLocation: SelectedLocation?
    
    init(
        rootRouter: CreateLocationRootRouterable,
        router: CreateLocationRouterable,
        onFinish: @escaping OnFinishFlow
    ) {
        self.rootRouter = rootRouter
        self.router = router
        self.onFinish = onFinish
    }
}

// MARK: - Coordinatable

extension CreateLocationCoordinator: Coordinatable {
    func start() {
        rootRouter.presentRoot(view: router.rootView, delegate: self)
    }
}

// MARK: - SelectLocationDelegate

extension CreateLocationCoordinator: SelectLocationDelegate {
    func onCancelTap() {
        rootRouter.dismissFullCover()
        onFinish(self)
    }
    
    func onNextTap(location: SelectedLocation) {
        selectedLocation = location
        router.showAddLocationInfo(delegate: self)
    }
}

// MARK: - AddLocationInfoDelegate

extension CreateLocationCoordinator: AddLocationInfoDelegate {
    
}
