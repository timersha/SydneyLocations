import Combine
import SwiftUI

protocol MapRouterStatable: ObservableObject {
    var path: NavigationPath { get set }
    var presentedItem: BaseSheetLink? { get set }
}

final class MapRouterState: MapRouterStatable {
    static let shared = MapRouterState()
    @Published var path = NavigationPath()
    @Published var presentedItem: BaseSheetLink?
}

