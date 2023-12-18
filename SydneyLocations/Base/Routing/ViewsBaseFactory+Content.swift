import SwiftUI

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeContent(type: BaseContentLink) -> some View {
        switch type {
            case let .map(delegate):
                MapViewAssembly.build(delegate: delegate)
            case let .locationsList(delegate):
                LocationsViewAssembly.build(delegate: delegate)
            case let .addLocationInfo(delegate):
                AddLocationInfoViewAssembly.build(delegate: delegate)
        }
    }
}
