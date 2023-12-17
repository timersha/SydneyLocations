import SwiftUI

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeContent(type: BaseContentLink) -> some View {
        switch type {
            case .map:
                MapViewAssembly.build()
        }
    }
}
