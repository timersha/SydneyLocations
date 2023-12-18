import Combine
import SwiftUI

protocol CreateLocationRouterStatable: ObservableObject {
    var path: NavigationPath { get set }
    var presentedItem: BaseSheetLink? { get set }
    var fullCoverItem: BaseFullCoverLink? { get set }
}

final class CreateLocationRouterState: CreateLocationRouterStatable {
    static var shared = CreateLocationRouterState()
    @Published var path = NavigationPath()
    @Published var presentedItem: BaseSheetLink?
    @Published var fullCoverItem: BaseFullCoverLink?
}

