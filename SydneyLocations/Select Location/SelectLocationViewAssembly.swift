import SwiftUI

enum SelectLocationViewAssembly {
    static func build(delegate: SelectLocationDelegate?) -> some View {
        let region = MapItemsFactory.makeRegion(place: .Sydney)
        let viewModel = SelectLocationViewModel(
            selectedRegion: region,
            delegate: delegate
        )
        let view = SelectLocationView(
            viewModel: viewModel,
            region: region
        )
        return view
    }
}
