import SwiftUI

enum AddLocationInfoViewAssembly {
    static func build(delegate: AddLocationInfoDelegate?) -> some View {
        let viewModel = AddLocationInfoViewModel(delegate: delegate)
        let view = AddLocationInfoView(viewModel: viewModel)
        return view
    }
}
