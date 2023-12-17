import SwiftUI

enum LocationsViewAssembly {
    static func build(delegate: LocationsViewItemsDelegate?) -> some View {
        let viewModel = LocationsViewModel(delegate: delegate)
        let view = LocationsView(viewModel: viewModel)
        return view
    }
}
