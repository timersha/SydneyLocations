import SwiftUI

enum LocationsViewAssembly {
    static func build() -> some View {
        let viewModel = LocationsViewModel()
        let view = LocationsView(viewModel: viewModel)
        return view
    }
}
