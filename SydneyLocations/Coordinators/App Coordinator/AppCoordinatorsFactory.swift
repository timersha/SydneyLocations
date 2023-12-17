import UIKit

protocol AppCoordinatorsFactoryProtocol {
    static func makeAppCoordinator(window: UIWindow?) -> Coordinatable

    static func makeMapCoordinator(
        appRouter: AppRouterable,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable
}

enum AppCoordinatorsFactory {}

// MARK: - AppCoordinatorsFactoryProtocol

extension AppCoordinatorsFactory: AppCoordinatorsFactoryProtocol {
    static func makeMapCoordinator(
        appRouter: AppRouterable,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable {
        MapCoordinatorAssembly.build(
            appRouter: appRouter,
            onFinish: onFinish
        )
    }
    
    static func makeAppCoordinator(window: UIWindow?) -> Coordinatable {
        AppCoordinatorAssembly.build(window: window)
    }
}
