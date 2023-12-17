import SwiftUI

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeSheet(type: BaseSheetLink) -> some View {
        switch type {
            case .locationInfo:
                EmptyView()
            case .locationsList:
                LocationsViewAssembly.build()
        }
    }
}
