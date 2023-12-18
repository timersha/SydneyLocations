import UIKit

protocol CoordinatorsFactoryProtocol {
    static func makeAppCoordinator(window: UIWindow?) -> Coordinatable

    static func makeMapCoordinator(
        appRouter: AppRouterable,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable
    
    static func makeCreateLocationCoordinator(
        rootRouterState: RootRouterState,
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
    
    static func makeCreateLocationCoordinator(
        rootRouterState: RootRouterState,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable {
        CreateLocationCoordinatorAssembly.build(
            rootRouterState: rootRouterState,
            onFinish: onFinish
        )
    }
}
