import SwiftUI

enum AddLocationViewAssembly {
    static func build() -> some View {
        let region = MapItemsFactory.makeRegion(place: .Sydney)
        let viewModel = AddLocationViewModel()
        let view = AddLocationView(
            viewModel: viewModel,
            region: region
        )
        return view
    }
}
