import Foundation

enum MapCoordinatorAssembly {
    static func build(
        appRouter: AppRouterable,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable {
        
        var router = MapRouter(
            state: MapRouterState.shared,
            factory: ViewsBaseFactory.self,
            content: MapViewAssembly.build(delegate: nil)
        )

        let coordinator = MapCoordinator(
            appRouter: appRouter,
            router: router,
            onFinish: onFinish
        )

        router.content = MapViewAssembly.build(delegate: coordinator)
        coordinator.router = router

        return coordinator
    }
}
