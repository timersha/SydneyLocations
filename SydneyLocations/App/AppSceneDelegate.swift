import UIKit
import SwiftUI

final class AppSceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var keyWindow: UIWindow?
    weak var windowScene: UIWindowScene?
    
    private let coordinatorsFactory: AppCoordinatorsFactoryProtocol.Type = AppCoordinatorsFactory.self
    private var appCoordintor: Coordinatable?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let wScene = scene as? UIWindowScene else { return }
        windowScene = wScene
        configureMainWindow(wScene: wScene)
        appCoordintor = coordinatorsFactory.makeAppCoordinator(window: keyWindow)
        appCoordintor?.start()
    }

    func configureMainWindow(wScene: UIWindowScene) {
        let window = UIWindow(windowScene: wScene)
        self.keyWindow = window
        window.makeKeyAndVisible()
    }
}
