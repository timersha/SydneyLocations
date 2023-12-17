import Combine
import SwiftUI

protocol MapRouterStatable: ObservableObject {
    var path: NavigationPath { get set }
    var presentedItem: BaseSheetLink? { get set }
    var fullCoverItem: BaseFullCoverLink? { get set }
}

final class MapRouterState: MapRouterStatable {
    static var shared = MapRouterState()
    @Published var path = NavigationPath()
    @Published var presentedItem: BaseSheetLink?
    @Published var fullCoverItem: BaseFullCoverLink?
}

