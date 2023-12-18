import Foundation
import SwiftUI

enum CreateLocationCoordinatorAssembly {
    static func build(
        rootRouterState: RootRouterState,
        onFinish: @escaping OnFinishFlow
    ) -> Coordinatable {
        
        let rootState = CreateLocationRootRouterState(
            path: rootRouterState.path,
            presentedItem: rootRouterState.presentedItem,
            fullCoverItem: rootRouterState.fullCoverItem
        )
        
        let rootRouter = CreateLocationRootRouter(state: rootState)
        
        var router = CreateLocationRouter(
            state: CreateLocationRouterState.shared,
            factory: ViewsBaseFactory.self,
            content: SelectLocationViewAssembly.build(delegate: nil)
        )
        let coordinator = CreateLocationCoordinator(
            rootRouter: rootRouter,
            router: router,
            onFinish: onFinish
        )
        
        router.content = SelectLocationViewAssembly.build(delegate: coordinator)
        coordinator.router = router
        
        return coordinator
    }
}
