import Foundation
import SwiftUI

struct RootRouterState {
    let path: Binding<NavigationPath>
    let presentedItem: Binding<BaseSheetLink?>
    let fullCoverItem: Binding<BaseFullCoverLink?>
}
