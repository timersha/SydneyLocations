import Foundation

final class AppCoordinator {
    var childCoordinators = [String: Coordinatable]()
    private let router: AppRouterable
    private let factory: CoordinatorsFactoryProtocol.Type
    
    init(
        router: AppRouterable,
        factory: CoordinatorsFactoryProtocol.Type = CoordinatorsFactory.self
    ) {
        self.router = router
        self.factory = factory
    }
}

// MARK: - Coordinatable

extension AppCoordinator: Coordinatable {

    func start() {
        let mapCoordinator = factory.makeMapCoordinator(appRouter: router) { [weak self] coordinator in
            guard let self = self else { return }
            self.remove(childCoordinator: coordinator)
            
        }
        add(childCoordinator: mapCoordinator)
        mapCoordinator.start()
    }
}
