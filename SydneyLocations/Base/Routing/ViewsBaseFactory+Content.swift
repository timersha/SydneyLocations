import SwiftUI

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeContent(type: BaseContentLink) -> some View {
        switch type {
            case let .map(delegate):
                MapViewAssembly.build(delegate: delegate)
            case .locationsList:
                LocationsViewAssembly.build()
        }
    }
}
