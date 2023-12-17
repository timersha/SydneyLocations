import UIKit
import SwiftUI

protocol AppRouterable {
    var window: UIWindow? { get set }
    
    func instantiateRoot(view: AnyView)
}

final class AppRouter {
    weak var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
}

// MARK: - AppRouterable

extension AppRouter: AppRouterable {
    func instantiateRoot(view: AnyView) {
        window?.rootViewController = UIHostingController(rootView: view)
        window?.makeKeyAndVisible()
    }
}
