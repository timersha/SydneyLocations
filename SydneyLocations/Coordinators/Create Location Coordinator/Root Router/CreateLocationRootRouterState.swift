import Combine
import SwiftUI

protocol CreateLocationRootRouterStatble: ObservableObject {
    var path: NavigationPath { get set }
    var presentedItem: BaseSheetLink? { get set }
    var fullCoverItem: BaseFullCoverLink? { get set }
    
    func update(path: Binding<NavigationPath>)
    func update(presentedItem: Binding<BaseSheetLink?>)
}

final class CreateLocationRootRouterState: CreateLocationRootRouterStatble {
    @Binding var path: NavigationPath
    @Binding var presentedItem: BaseSheetLink?
    @Binding var fullCoverItem: BaseFullCoverLink?
    
    init(
        path: Binding<NavigationPath>,
        presentedItem: Binding<BaseSheetLink?>,
        fullCoverItem: Binding<BaseFullCoverLink?>
    ) {
        self._path = path
        self._presentedItem = presentedItem
        self._fullCoverItem = fullCoverItem
    }
    
    func update(path: Binding<NavigationPath>) {
        _path = path
    }
    
    func update(presentedItem: Binding<BaseSheetLink?>) {
        _presentedItem = presentedItem
    }
    
    func update(fullCoverItem: Binding<BaseFullCoverLink?>) {
        _fullCoverItem = fullCoverItem
    }
}

