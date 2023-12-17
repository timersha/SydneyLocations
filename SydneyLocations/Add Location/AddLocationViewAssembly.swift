import SwiftUI

enum AddLocationViewAssembly {
    static func build(delegate: AddLocationDelegate?) -> some View {
        let region = MapItemsFactory.makeRegion(place: .Sydney)
        let viewModel = AddLocationViewModel(delegate: delegate)
        let view = AddLocationView(
            viewModel: viewModel,
            region: region
        )
        return view
    }
}
