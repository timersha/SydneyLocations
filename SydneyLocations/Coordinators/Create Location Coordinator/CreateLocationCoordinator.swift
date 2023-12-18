import Foundation

final class CreateLocationCoordinator {
    var childCoordinators = [String: Coordinatable]()
    var router: CreateLocationRouterable
    private let coreDataService: CoreDataServiceProtocol
    private let rootRouter: CreateLocationRootRouterable
    private let onFinish: OnFinishFlow
    private var selectedLocation: SelectedLocation?
    
    init(
        rootRouter: CreateLocationRootRouterable,
        router: CreateLocationRouterable,
        coreDataService: CoreDataServiceProtocol = CoreDataService.shared,
        onFinish: @escaping OnFinishFlow
    ) {
        self.rootRouter = rootRouter
        self.router = router
        self.coreDataService = coreDataService
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
    func onSaveTap(
        name: String,
        description: String,
        saveCompletion: @escaping () -> Void
    ) {
        guard let latitude: Double = selectedLocation?.region.center.latitude,
              let longitude: Double = selectedLocation?.region.center.longitude
        else {
            return
        }
        Task {
            let location = Location(
                id: UUID(),
                name: name,
                latitude: latitude,
                longitude: longitude,
                descriptionText: description
            )
            await coreDataService.create(location: location)
            await MainActor.run {
                saveCompletion()
                rootRouter.dismissFullCover()
                onFinish(self)
            }
        }
    }
}
