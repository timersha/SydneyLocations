import SwiftUI

extension ViewsBaseFactory {
    @ViewBuilder
    static func makeFullCover(type: BaseFullCoverLink) -> some View {
        switch type {
            case let .addLocation(delegate):
                AddLocationViewAssembly.build(delegate: delegate)
        }
    }
}
