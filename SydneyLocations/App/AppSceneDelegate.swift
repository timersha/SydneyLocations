import UIKit
import SwiftUI

final class AppSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var keyWindow: UIWindow?
    weak var windowScene: UIWindowScene?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let wScene = scene as? UIWindowScene else { return }
        windowScene = wScene
        configureMainWindow(wScene: wScene)
    }

    func configureMainWindow(wScene: UIWindowScene) {
        let window = UIWindow(windowScene: wScene)
        window.rootViewController = UIHostingController(rootView: MapViewAssembly.build())
        self.keyWindow = window
        window.makeKeyAndVisible()
    }
}
