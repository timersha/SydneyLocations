import SwiftUI

enum AddLocationInfoViewAssembly {
    static func build() -> some View {
        let viewModel = AddLocationInfoViewModel()
        let view = AddLocationInfoView(viewModel: viewModel)
        return view
    }
}
