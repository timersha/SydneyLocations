import UIKit
import SwiftUI

enum AppCoordinatorAssembly {
    static func build(window: UIWindow?) -> Coordinatable {
        let router = AppRouter(window: window)
        let coordinator = AppCoordinator(router: router)
        return coordinator
    }
}
