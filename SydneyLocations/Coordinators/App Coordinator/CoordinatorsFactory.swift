import UIKit

protocol CoordinatorsFactoryProtocol {
    static func makeAppCoordinator(window: UIWindow?) -> Coordinatable

    static func makeMapCoordinator(
        appRouter: AppRouterable,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable
}

enum CoordinatorsFactory {}

// MARK: - CoordinatorsFactoryProtocol

extension CoordinatorsFactory: CoordinatorsFactoryProtocol {
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
