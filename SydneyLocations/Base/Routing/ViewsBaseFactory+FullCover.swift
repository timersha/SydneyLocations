import SwiftUI

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeFullCover(type: BaseFullCoverLink) -> some View {
        switch type {
            case let .selectLocation(delegate):
                SelectLocationViewAssembly.build(delegate: delegate)
            case let .custom(view):
                view
        }
    }
}
