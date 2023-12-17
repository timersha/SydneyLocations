import Foundation

enum MapCoordinatorAssembly {
    static func build(
        appRouter: AppRouterable,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable {
        let router = MapRouter(
            state: MapRouterState.shared,
            factory: ViewsBaseFactory.self,
            content: MapViewAssembly.build
        )
        let coordinator = MapCoordinator(
            appRouter: appRouter,
            router: router,
            onFinish: onFinish
        )
        return coordinator
    }
}
