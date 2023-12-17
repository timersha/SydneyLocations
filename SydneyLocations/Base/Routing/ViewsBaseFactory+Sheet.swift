import SwiftUI

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeSheet(type: BaseSheetLink) -> some View {
        switch type {
            case let .locationInfo(model, delegate):
                LocationInfoViewAssembly.build(
                    model: model,
                    delegate: delegate
                )
            case let .locationsList(delegate):
                LocationsViewAssembly.build(delegate: delegate)
        }
    }
}
