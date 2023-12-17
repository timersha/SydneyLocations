import Foundation

typealias OnFinishFlow = (Coordinatable) -> Void

protocol Coordinatable: AnyObject {
    var childCoordinators: [String: Coordinatable] { get set }
    
    func start()
    func add(childCoordinator coordinator: Coordinatable)
    func remove(childCoordinator coordinator: Coordinatable)
}

extension Coordinatable {
    
    func start() {
        fatalError("Not implemented")
    }
    
    func add(childCoordinator coordinator: Coordinatable) {
        let name = String(describing: coordinator)
        childCoordinators[name] = coordinator
    }
    
    func remove(childCoordinator coordinator: Coordinatable) {
        let name = String(describing: coordinator)
        childCoordinators.removeValue(forKey: name)
    }
}
