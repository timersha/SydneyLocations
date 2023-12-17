import SwiftUI

enum LocationInfoViewAssembly {
    static func build(
        model: LocationInfo,
        delegate: LocationInfoViewModelDelegate?
    ) -> some View {
        let viewModel = LocationInfoViewModel(
            model: model,
            delegate: delegate
        )
        let view = LocationInfoView(viewModel: viewModel)
        return view
    }
}
